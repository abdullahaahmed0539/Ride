const Booking = require("../../models/Bookings");
const {
  serverErrorResponse,
  onMissingValResponse,
  notFoundResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "BOOKING_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  MISSING_VAL: "MISSING_VAL",
};

exports.bookingDetails = async (req, res) => {
  const bookingId = req.params.booking_id;
  if (!bookingId) {
    onMissingValResponse(res, errorCodes.MISSING_VAL, "booking id is missing.");
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
    } else {
      res.status(200).json({
        request: "successful",
        error: {},
        data: {
          booking,
        },
      });
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
