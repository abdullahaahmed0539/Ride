const User = require("../../models/Users");
const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");
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
  const { riderId, driverId, newRatingVal, bookingId } = req.body;
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
    const booking = await Booking.findOne({ _id: bookingId, driverId });
    if (!booking) {
      unAuthorizedResponse(res, "UNAUTHORIZED_ACCESS");
      return;
    }
    const userDetails = await User.findById({ _id: riderId }).select("ratings");
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
    await User.updateOne({ _id: riderId  }, { ratings: userRating });
    await Trip.updateOne({ bookingId }, { riderRating: newRatingVal });
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
