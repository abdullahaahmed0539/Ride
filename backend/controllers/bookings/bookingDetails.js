const Booking = require("../../models/Bookings");
const {
  serverErrorResponse,
  onMissingValResponse,
  notFoundResponse,
  unAuthorizedResponse,
  successfulGetResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "BOOKING_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  MISSING_VAL: "MISSING_VAL",
  UNAUTHORIZED: "UNAUTHORIZED_ACCESS",
};

exports.bookingDetails = async (req, res) => {
  const { bookingId, userId } = req.body;
  if (!bookingId || !userId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "booking id or user id is missing."
    );
    return;
  }

  try {
    const booking = await Booking.findById({ _id: bookingId });
    if (!booking) {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "BOOKING_NOT_FOUND",
        "There is no booking against the booking id."
      );
    } else if (booking.riderId === userId || booking.driverId === userId) {
      successfulGetResponse(res, { booking });
    } else {
      unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
