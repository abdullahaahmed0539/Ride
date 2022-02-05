const { default: phone } = require("phone");
const User = require("../../models/Users");

const errorCodes = {
  NOT_FOUND: "USR_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.userDetails = async (req, res) => {
  const phoneNumber = req.params.phoneNumber;
  try {
    const userDetails = await User.findOne({ phoneNumber }).select(
      "-phoneNumber"
    );
    if (userDetails) {
      res.status(200).json({
        request: "successful",
        error: {},
        data: {
          userDetails,
        },
      });
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
