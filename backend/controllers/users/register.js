/*
DOCUMENTATION
types of errors:
* not connected to database = db-001
* missing attribute = missing-attr
* incorrect format = bad-format ----> need to implement this
* not unique = not-unique

NEED TO IMPLEMENT
*validate wallet address

*/

const mongoose = require("mongoose");
const User = require("../../models/Users");
const { AES_encrypt } = require("../../helper/encryption");
const { validateUserInfo } = require("../../helper/validators");
const { default: phone } = require("phone");

const errorCodes = {
  DATABASE_NOT_CONNECTED: "db-not-conn",
  MISSING_ATTRIBUTE: "missing-attr",
  INCORRECT_FORMAT: "incorrect-format",
  NOT_UNIQUE: "not-unique",
};

exports.register = (req, res) => {
  const { phoneNumber, country, firstName, lastName, email, walletAddress } =
    req.body;

  //validate format
  const isValidFormat = validateUserInfo(email, phoneNumber, country);

  if (isValidFormat) {
    encryptedWalletAddress = AES_encrypt(walletAddress);
  } else {
    res.status(406).json({
      error: {
        code: errorCodes.INCORRECT_FORMAT,
        name: "format error",
        message: "Either phone number or email is invalid",
        logs: "",
      },
      data: {},
    });
    return;
  }

  const newUser = new User({
    phoneNumber,
    country,
    firstName,
    lastName,
    email,
    walletAddress: encryptedWalletAddress,
    isDriver: false,
    rating: 0,
  });

  newUser
    .save()
    .then(user => {
      res.status(201).json({
        error: {},
        data: {
          user,
        },
      });
    })
    .catch(err => {
      if (err.name === "MongoServerError" && err.code === 11000) {
        res.status(406).json({
          error: {
            code: errorCodes.NOT_UNIQUE,
            name: err.name,
            message: err.message,
            logs: err.keyValue,
          },
          data: {},
        });
      } else if (err.name === "ValidationError") {
        res.status(406).json({
          error: {
            code: errorCodes.MISSING_ATTRIBUTE,
            name: err.name,
            message: err.message,
            logs: "",
          },
          data: {},
        });
      } else {
        res.status(500).json({
          error: {
            code: errorCodes.DATABASE_NOT_CONNECTED,
            name: err.name,
            message: err.message,
            logs: "",
          },
          data: {},
        });
      }
    });
};
