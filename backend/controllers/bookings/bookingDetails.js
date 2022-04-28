const Booking = require("../../models/Bookings");
const {
  serverErrorResponse,
  onMissingValResponse,
  notFoundResponse,
  successfulGetResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "BOOKING_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  MISSING_VAL: "MISSING_VAL",
  UNAUTHORIZED: "UNAUTHORIZED_ACCESS",
};

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
        errorCodes.NOT_FOUND,
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
