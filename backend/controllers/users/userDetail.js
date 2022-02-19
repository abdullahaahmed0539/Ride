const User = require("../../models/Users");
const {
  successfulGetResponse,
  notFoundResponse,
  serverErrorResponse,
  onMissingValResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "USR_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  MISSING_VAL: "MISSING_VALUE",
};

exports.userDetails = async (req, res) => {
  const phoneNumber = req.body.phone_number;
  //making sure if phone number is available
  if (!phoneNumber) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Phone number is missing."
    );
    return;
  }

  try {
    //retrieving from database
    const userDetails = await User.findOne({ phoneNumber }).select(
      "-phoneNumber"
    );
    userDetails
      ? successfulGetResponse(res, userDetails)
      : notFoundResponse(
          res,
          errorCodes.NOT_FOUND,
          "UserNotFound",
          "The following user does not exist."
        );
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
