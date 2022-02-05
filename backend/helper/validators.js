const { phone } = require("phone");
var emailValidator = require("email-validator");

exports.validatePhoneNumber = (phoneNumber, country) => {
  return phone(phoneNumber, { country }).isValid;
};

exports.validateEmail = email => {
  return emailValidator.validate(email);
};

exports.validateUserInfo = (email, phoneNumber, country) => {
  return (
    this.validateEmail(email) && this.validatePhoneNumber(phoneNumber, country)
  );
};
