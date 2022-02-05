const User = require("../../models/Users");

const errorCodes = {
  NOT_FOUND: "USR_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  VALUE_NOT_ACCEPTABLE: "VALUE_NOT_ACCEPTABLE",
};

exports.addUserRating = async (req, res) => {
  const phoneNumber = req.params.phoneNumber;
  const newRatingVal = req.body.rating;
  if (newRatingVal < 0 || newRatingVal > 5) {
    res.status(406).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.VALUE_NOT_ACCEPTABLE,
        name: "unacceptableValue",
        message: "Rating not in range 0 to 5.",
        logs: "",
      },
      data: {},
    });
    return;
  }

  try {
    const userDetails = await User.findOne({ phoneNumber }).select("ratings");
    if (!userDetails) {
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
      return;
    }
    const userRating = userDetails.ratings;
    userRating.push(newRatingVal);
    await User.updateOne({ phoneNumber }, { ratings: userRating });
    res.status(201).json({
      request: "successful",
      error: {},
      data: {
        phoneNumber,
        rating: userRating,
      },
    });
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
