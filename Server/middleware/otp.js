function generateOTP() {
    const length = 6;
    const charset = '0123456789';
    let OTP = '';
  
    for (let i = 0; i < length; i++) {
      const randomIndex = Math.floor(Math.random() * charset.length);
      OTP += charset[randomIndex];
    }
  
    return OTP;
  }
  
//   const otp = generateOTP();
//   console.log('Generated OTP:', otp);

  module.exports = {
    generateOTP
}