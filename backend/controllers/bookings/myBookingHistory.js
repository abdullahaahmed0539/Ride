const Booking = require("../../models/Bookings");

const {
  serverErrorResponse,
  notFoundResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "BOOKINGS_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.myBookingHistory = async (req, res) => {
  const riderId = req.body.rider_id;
  try {
    const myBookings = await Booking.find({
      riderId,
      $or: [{ status: "completed" }, { status: "cancelled" }],
    });
    if (myBookings.length > 0) {
      res.status(200).json({
        request: "successful",
        error: {},
        data: {
          myBookings,
        },
      });
    } else {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "NO_BOOKINGS",
        "There are no bookings."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
