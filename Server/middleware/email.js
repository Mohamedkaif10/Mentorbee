const nodemailer = require('nodemailer');
const { EMAIL, PASSWORD } = require('../env.js');
const otpmail = require("./otp");
const Mailgen = require('mailgen');
const sendOTPByEmail = (email,otp) => {
  let config = {
    service: 'gmail',
    auth: {
      user: EMAIL,
      pass: PASSWORD,
    },
  };

  let transporter = nodemailer.createTransport(config);

  const mailOptions = {
    from: EMAIL,
    to: email, // Changed to the 'email' parameter
    subject: 'OTP',
    text: `Your login OTP is ${otp}.`,
  };

  // Send the email and handle the result
  transporter.sendMail(mailOptions)
    .then(() => {
      console.log("Email sent successfully"); // Log success message
    })
    .catch(error => {
      console.error("Error sending email:", error); // Log the error
    });
};





// const sendOTPByEmail = (req, res) => {
//     const email  = "xogiwe8361@weirby.com";
//     const otp=21353;
//     console.log("the mail otp is ",otp)
//     let config = {
//         service : 'gmail',
//         auth : {
//             user: EMAIL,
//             pass: PASSWORD
//         }
//     }

//     let transporter = nodemailer.createTransport(config);

//     let MailGenerator = new Mailgen({
//         theme: "default",
//         product : {
//             name: "Mailgen",
//             link : 'https://mailgen.js/'
//         }
//     })

//     let response = {
//         body: {
//             name : "Daily Tuition",
//             intro: "Your bill has arrived!",
//             table : {
//                 data : [
//                     {
//                         item : otp,
//                         description: "A Backend application",
//                         price : "$10.99",
//                     }
//                 ]
//             },
//             outro: "Looking forward to do more business"
//         }
//     }

//     let mail = MailGenerator.generate(response)

//     let message = {
//         from : EMAIL,
//         to : email,
//         subject: "Place Order",
//         html: mail
//     }

//     transporter.sendMail(message).then(() => {
//         return res.status(201).json({
//             msg: "you should receive an email"
//         })
//     }).catch(error => {
//         return res.status(500).json({ error })
//     })

//     res.status(201).json("getBill Successfully...!");
// }

module.exports = {
  sendOTPByEmail,
};
