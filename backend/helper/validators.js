const { phone } = require("phone");
const emailValidator = require("email-validator");
const pakCnicValidator = require("stdnum").stdnum.PK.cnic;

exports.validatePhoneNumber = (phoneNumber, country) => phone(phoneNumber, { country }).isValid;

exports.validateEmail = email => emailValidator.validate(email);

exports.validateUserInfo = (email, phoneNumber, country) => this.validateEmail(email) &&
  this.validatePhoneNumber(phoneNumber, country)
  
exports.validateCNIC = cnic =>  pakCnicValidator.validate(cnic).isValid;

exports.validateMetamask = address => address.length === 42;


