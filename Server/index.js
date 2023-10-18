const express = require("express");
const connectDb = require("./config/dbConnection");
const bodyParser = require('body-parser');
const dotenv = require("dotenv").config();
const some = require("./middleware/otp");
const mail = require("./middleware/email");
const OTPModel = require("./model/otpmodel"); // Import your Mongoose model

connectDb();

const app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const port = process.env.PORT || 8001;

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
      res.status(500).json({ success: false, message: 'Failed to send OTP' });
    }
  });

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
