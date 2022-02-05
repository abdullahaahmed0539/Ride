const User = require("../../models/Users");

const errorCodes = {
  NOT_FOUND: "USR_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.updateName = async (req, res) => {
  const phoneNumber = req.params.phoneNumber;
  const { firstName, lastName } = req.body;
  const updatedVals = { firstName, lastName };

  try {
    const updatedUser = await User.updateOne({ phoneNumber }, updatedVals);
    if (updatedUser.modifiedCount > 0) {
      res.status(201).json({
        request: "successful",
        error: {},
        data: {
          phoneNumber,
          updated_first_name: firstName,
          updated_last_name: lastName,
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
