const { phone } = require("phone");
const emailValidator = require("email-validator");
const pakCnicValidator = require("stdnum").stdnum.PK.cnic;

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

exports.validateCNIC = cnic => {
  return pakCnicValidator.validate(cnic).isValid;
};
