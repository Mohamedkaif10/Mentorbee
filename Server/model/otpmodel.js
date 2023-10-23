const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const otpSchema = new Schema({
  email: String,
  otp: String,
  timestamp: { type: Date, default: Date.now },
});

const OTPModel = mongoose.model('OTP', otpSchema);

module.exports = OTPModel;
