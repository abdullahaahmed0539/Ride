const User = require("../../models/Users");
const { validateEmail } = require("../../helper/validators");

const errorCodes = {
  NOT_FOUND: "USR_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  INCORRECT_FORMAT: "INCORRECT-FORMAT",
};

exports.updateEmail = async (req, res) => {
  const phoneNumber = req.params.phoneNumber;
  const email = req.body.email;

  if (!validateEmail(email)) {
    res.status(406).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.INCORRECT_FORMAT,
        name: "format error",
        message: "email is invalid.",
        logs: "",
      },
      data: {},
    });
    return;
  }

  const updatedVals = { email };

  try {
    const updatedUser = await User.updateOne({ phoneNumber }, updatedVals);
    if (updatedUser.modifiedCount > 0) {
      res.status(201).json({
        request: "successful",
        error: {},
        data: {
          phoneNumber,
          updated_email: email,
        },
      });
    } else if (
      updatedUser.modifiedCount === 0 &&
      updatedUser.matchedCount > 0
    ) {
      res.status(204).json({});
    } else {
      res.status(404).json({
        request: "unsuccessful",
        error: {
          code: errorCodes.NOT_FOUND,
          name: "userNotFound",
          message: "The following user does not exist.",
          logs: "",
        },
        data: {},
      });
    }
  } catch (err) {
    res.status(500).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.SERVER_ERROR,
        name: err.name,
        message: err.message,
        logs: err,
      },
      data: {},
    });
  }
};
