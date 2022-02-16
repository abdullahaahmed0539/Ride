const Booking = require("../../models/Bookings");
const {
  serverErrorResponse,
  onCreationResponse,
  notFoundResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "BOOKING_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.riderCancellation = async (req, res) => {
  const bookingId = req.body.booking_id;

  try {
    const updatedBooking = await Booking.updateOne(
      { _id: bookingId },
      { status: "cancelled" }
    );
    if (updatedBooking.modifiedCount > 0) {
      onCreationResponse(res, {
        bookingId,
        status: "cancelled",
      });
    } else if (
      updatedBooking.modifiedCount === 0 &&
      updatedBooking.matchedCount > 0
    ) {
      res.status(204).json({});
    } else {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "bookingNotFound",
        "The following booking does not exist."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};

exports.driverCancellation = async (req, res) => {
  const bookingId = req.body.booking_id;

  try {
    const updatedBooking = await Booking.updateOne(
      { _id: bookingId },
      { driverId: null, status: "insearch" }
    );
    if (updatedBooking.modifiedCount > 0) {
      onCreationResponse(res, {
        bookingId,
        status: "cancelled",
      });
    } else if (
      updatedBooking.modifiedCount === 0 &&
      updatedBooking.matchedCount > 0
    ) {
      res.status(204).json({});
    } else {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "bookingNotFound",
        "The following booking does not exist."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
