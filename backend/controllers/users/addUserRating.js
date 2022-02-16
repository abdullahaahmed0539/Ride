const User = require("../../models/Users");
const {
  serverErrorResponse,
  onCreationResponse,
  notFoundResponse,
} = require("../../helper/responses");

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
      notFoundResponse(
        errorCodes.NOT_FOUND,
        "userNotFound",
        "The following user does not exist."
      );

      return;
    }
    const userRating = userDetails.ratings;
    userRating.push(newRatingVal);
    await User.updateOne({ phoneNumber }, { ratings: userRating });
    onCreationResponse({
      phoneNumber,
      rating: userRating,
    });
  } catch (err) {
    serverErrorResponse(err, errorCodes.SERVER_ERROR);
  }
};
