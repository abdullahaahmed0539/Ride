const User = require("../../models/Users");
const { validateEmail } = require("../../helper/validators");
const { errorCodes } = require("../../helper/errorCodes");

const {
  incorrectFormatResponse,
  onCreationResponse,
  notFoundResponse,
  onMissingValResponse,
  serverErrorResponse,
} = require("../../helper/responses");

exports.updateEmail = async (req, res) => {
  const { phoneNumber, email } = req.body;

  //check for missing values
  if (!phoneNumber || !email) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Phone number or email is missing."
    );
    return;
  }

  //validate email format
  if (!validateEmail(email)) {
    incorrectFormatResponse(
      res,
      errorCodes.INCORRECT_FORMAT,
      "FormatError",
      "Email is format invalid."
    );
    return;
  }

  try {
    //update user email
    const updatedUser = await User.updateOne({ phoneNumber }, { email });
    if (updatedUser.modifiedCount > 0) {
      onCreationResponse(res, {
        phoneNumber,
        updated_email: email,
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
