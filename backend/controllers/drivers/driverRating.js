const Driver = require("../../models/Drivers");
const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");
const {errorCodes} = require('../../helper/errorCodes')

const {
  serverErrorResponse,
  onCreationResponse,
  notFoundResponse,
  incorrectFormatResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");

exports.addDriverRating = async (req, res) => {
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
    const booking = await Booking.findOne({ _id: bookingId, riderId });
    if (!booking) {
      unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
      return;
    }
    const driverDetails = await Driver.findById({ _id: driverId }).select(
      "ratings"
    );
    if (!driverDetails) {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "UserNotFound",
        "The following user does not exist."
      );
      return;
    }
    const driverRating = driverDetails.ratings;
    driverRating.push(newRatingVal);
    await Driver.updateOne({ _id: driverId }, { ratings: driverRating });
    await Trip.updateOne({ bookingId }, { driverRating: newRatingVal });
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
