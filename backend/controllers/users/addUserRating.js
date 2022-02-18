const User = require("../../models/Users");
const {
  serverErrorResponse,
  onCreationResponse,
  notFoundResponse,
  incorrectFormatResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "USER_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  VALUE_NOT_ACCEPTABLE: "VALUE_NOT_ACCEPTABLE",
};

exports.addUserRating = async (req, res) => {
  const phoneNumber = req.params.phoneNumber;
  const newRatingVal = req.body.rating;
  // const { userId, isRider, newRatingVal } = req.body;
  if (newRatingVal < 0 || newRatingVal > 5) {
    incorrectFormatResponse(
      res,
      errorCodes.VALUE_NOT_ACCEPTABLE,
      "UnacceptableValue",
      "Rating not in range 0 to 5."
    );
    return;
  }

  try {
    const userDetails = await User.findOne({ phoneNumber }).select("ratings");
    if (!userDetails) {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "UserNotFound",
        "The following user does not exist."
      );
      return;
    }
    const userRating = userDetails.ratings;
    userRating.push(newRatingVal);
    await User.updateOne({ phoneNumber }, { ratings: userRating });
    onCreationResponse(res, {
      phoneNumber,
      rating: userRating,
    });
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
