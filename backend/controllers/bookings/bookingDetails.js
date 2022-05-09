const Booking = require("../../models/Bookings");
const {errorCodes} = require('../../helper/errorCodes');
const {
  serverErrorResponse,
  onMissingValResponse,
  notFoundResponse,
  successfulGetResponse,
} = require("../../helper/responses");

exports.bookingDetails = async (req, res) => {
  const { driverId, riderId } = req.body;
  if (!driverId || !driverId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Driver id or user id is missing."
    );
    return;
  }

  try {
    const booking = await Booking.findOne({
      riderId,
      driverId,
      status: "accepted",
    });
    if (!booking) {
      notFoundResponse(
        res,
        errorCodes.BOOKING_NOT_FOUND,
        "BOOKING_NOT_FOUND",
        "There is no booking against the booking id."
      );
    } else {
      successfulGetResponse(res, { booking });
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
