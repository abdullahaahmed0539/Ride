const User = require("../../models/Users");
const {
  successfulGetResponse,
  notFoundResponse,
  serverErrorResponse,
  onMissingValResponse,
} = require("../../helper/responses");
const { errorCodes } = require("../../helper/errorCodes");

exports.userDetails = async (req, res) => {
  const phoneNumber = req.body.phoneNumber;
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
      "-ratings -walletHash"
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
