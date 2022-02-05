const User = require("../../models/Users");
const { validatePhoneNumber } = require("../../helper/validators");

const errorCodes = {
  NOT_FOUND: "USR_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  INCORRECT_FORMAT: "INCORRECT-FORMAT",
};

exports.updatePhoneNumber = async (req, res) => {
  const phoneNumber = req.params.phoneNumber;
  const { _phoneNumber, country } = req.body;

  if (!validatePhoneNumber(_phoneNumber, country)) {
    res.status(406).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.INCORRECT_FORMAT,
        name: "formatError",
        message: "phone number is invalid.",
        logs: "",
      },
      data: {},
    });
    return;
  }

  const updatedVals = { phoneNumber: _phoneNumber };

  try {
    const updatedUser = await User.updateOne({ phoneNumber }, updatedVals);
    if (updatedUser.modifiedCount > 0) {
      res.status(201).json({
        request: "successful",
        error: {},
        data: {
          phoneNumber,
          updated_phoneNumber: _phoneNumber,
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
