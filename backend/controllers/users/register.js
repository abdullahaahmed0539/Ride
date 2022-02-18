/*

NEED TO IMPLEMENT
*validate wallet address

*/

const User = require("../../models/Users");
const { AES_encrypt } = require("../../helper/encryption");
const { validateUserInfo } = require("../../helper/validators");
const {
  serverErrorResponse,
  onCreationResponse,
} = require("../../helper/responses");

const errorCodes = {
  DATABASE_NOT_CONNECTED: "DB-NOT-CONNECTED",
  MISSING_ATTRIBUTE: "MISSING-ATTR",
  INCORRECT_FORMAT: "INCORRECT-FORMAT",
  NOT_UNIQUE: "NOT-UNIQUE",
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
      request: "unsuccessful",
      error: {
        code: errorCodes.INCORRECT_FORMAT,
        name: "formatError",
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
    rating: [],
  });

  newUser
    .save()
    .then(user => {
      onCreationResponse({});
    })
    .catch(err => {
      if (err.name === "MongoServerError" && err.code === 11000) {
        res.status(406).json({
          request: "unsuccessful",
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
          request: "unsuccessful",
          error: {
            code: errorCodes.MISSING_ATTRIBUTE,
            name: err.name,
            message: err.message,
            logs: "",
          },
          data: {},
        });
      } else {
        serverErrorResponse(err, errorCodes.DATABASE_NOT_CONNECTED);
      }
    });
};
