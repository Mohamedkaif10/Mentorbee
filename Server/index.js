const express = require("express");
const connectDb = require("./config/dbConnection");
const bodyParser = require('body-parser');
const dotenv = require("dotenv").config();
const some = require("./middleware/otp");
const mail = require("./middleware/email");
const OTPModel = require("./model/otpmodel"); // Import your Mongoose model
const BuddyModel = require('./model/buddyModel');
connectDb();

const app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const port = process.env.PORT || 8010;

app.use(express.json());

app.post('/sendOtp', async (req, res) => {
    const {email} = req.body;
    
    try {
      const otp=some.generateOTP();
      console.log("hello",otp) 
      await mail.sendOTPByEmail(email, otp); 
      const otpRecord = new OTPModel({
        email,
        otp,
      });
      await otpRecord.save();
    
      res.json({ success: true, message: 'OTP sent successfully' });
    } catch (error) {
      console.error("Error:", error); // Log the error for debugging
      console.log(error)
      res.status(500).json({ success: false, message: 'Failed to send OTP' });
    }
  });


  app.post('/verifyOtp', async (req, res) => {
    const userOTP = req.body.otp;
  
    try {
      const otpRecord = await OTPModel.findOne({ otp: userOTP });
  
      if (!otpRecord) {
        // Return a 400 status code for a bad request
        return res.status(400).json({ success: false, message: 'Invalid OTP' });
      }
  
      // Perform your verification logic here
  
      // Delete the OTP record to prevent further use of the OTP
      await OTPModel.deleteOne({ _id: otpRecord._id });
  
      res.json({ success: true, message: 'Login successful' });
    } catch (error) {
      console.error("Error:", error);
      res.status(500).json({ success: false, message: 'Failed to verify OTP' });
    }
  });
  
  app.get('/buddies', async (req, res) => {
    try {
        const data = await BuddyModel.find({}).exec();
        res.status(200).json(data);
    } catch (err) {
        res.status(500).send('Error fetching data');
    }
});
app.get('/buddies/:id', async (req, res) => {
  try {
    const buddy = await BuddyModel.findById(req.params.id).exec();
    if (buddy) {
      res.status(200).json(buddy);
    } else {
      res.status(404).send('Buddy not found');
    }
  } catch (err) {
    res.status(500).send('Error fetching data');
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
