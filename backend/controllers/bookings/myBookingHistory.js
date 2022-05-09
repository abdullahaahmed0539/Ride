const Booking = require("../../models/Bookings");
const {errorCodes} = require('../../helper/errorCodes')
const {
  successfulGetResponse,
  serverErrorResponse,
  notFoundResponse,
  onMissingValResponse,
} = require("../../helper/responses");


exports.myBookingHistory = async (req, res) => {
  const riderId = req.body.riderId;
  if (!riderId) {
    onMissingValResponse(res, errorCodes.MISSING_VAL, "Rider id is missing.");
    return;
  }

  try {
    const myBookings = await Booking.find({
      riderId,
      $or: [{ status: "completed" }, { status: "cancelled" }],
    });
    if (myBookings.length > 0) {
      successfulGetResponse(res, { myBookings });
    } else {
      notFoundResponse(
        res,
        errorCodes.BOOKING_NOT_FOUND,
        "NO_BOOKINGS",
        "There are no bookings."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
