const User = require("../../models/Users");
const {
  onCreationResponse,
  notFoundResponse,
  onMissingValResponse,
  serverErrorResponse,
} = require("../../helper/responses");
const { errorCodes } = require("../../helper/errorCodes");

exports.updateName = async (req, res) => {
  const { firstName, lastName, phoneNumber } = req.body;
  if (!firstName || !lastName || !phoneNumber) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "First name, last name or phone number is missing."
    );
    return;
  }

  try {
    const updatedUser = await User.updateOne(
      { phoneNumber },
      { firstName, lastName }
    );
    if (updatedUser.modifiedCount > 0) {
      onCreationResponse(res, {
        phoneNumber,
        updated_first_name: firstName,
        updated_last_name: lastName,
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
