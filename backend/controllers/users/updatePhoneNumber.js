const jwt = require("jsonwebtoken");
const User = require("../../models/Users");
const { validatePhoneNumber } = require("../../helper/validators");
const {
  incorrectFormatResponse,
  onCreationResponse,
  notFoundResponse,
  onMissingValResponse,
  serverErrorResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "USR_NOT_FOUND",
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  INCORRECT_FORMAT: "INCORRECT-FORMAT",
};

exports.updatePhoneNumber = async (req, res) => {
  const { phoneNumber, newPhoneNumber, country } = req.body;

  if (!phoneNumber || !newPhoneNumber || !country) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Phone number, new phone number or country is missing."
    );
    return;
  }

  if (!validatePhoneNumber(newPhoneNumber, country)) {
    incorrectFormatResponse(
      res,
      errorCodes.INCORRECT_FORMAT,
      "FormatError",
      "Phone number is invalid."
    );
    return;
  }

  try {
    const updatedUser = await User.updateOne(
      { phoneNumber },
      { phoneNumber: newPhoneNumber }
    );
    if (updatedUser.modifiedCount > 0) {
      const user = await User.findOne({ newPhoneNumber }).select(
        "_id isDriver"
      );
      let token = jwt.sign(
        {
          _id: user._id,
          phoneNumber: newPhoneNumber,
          isDriver: user.isDriver,
        },
        process.env.TOKEN_KEY,
        { expiresIn: "24h" }
      );
      onCreationResponse(res, {
        phoneNumber,
        updated_phoneNumber: newPhoneNumber,
        country,
        token,
      });
    } else if (
      updatedUser.modifiedCount === 0 &&
      updatedUser.matchedCount > 0
    ) {
      res.status(204).json({});
    } else {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "UserNotFound",
        "The following user does not exist."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
