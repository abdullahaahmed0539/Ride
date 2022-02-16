const Booking = require("../../models/Bookings");
const { serverErrorResponse } = require("../../helper/responses");

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
      res.status(201).json({
        request: "successful",
        error: {},
        data: {
          bookingId,
          status: "cancelled",
        },
      });
    } else if (
      updatedBooking.modifiedCount === 0 &&
      updatedBooking.matchedCount > 0
    ) {
      res.status(204).json({});
    } else {
      res.status(404).json({
        request: "unsuccessful",
        error: {
          code: errorCodes.NOT_FOUND,
          name: "bookingNotFound",
          message: "The following booking does not exist.",
          logs: "",
        },
        data: {},
      });
    }
  } catch (err) {
    serverErrorResponse(err, errorCodes.SERVER_ERROR);
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
      res.status(201).json({
        request: "successful",
        error: {},
        data: {
          bookingId,
          status: "cancelled",
        },
      });
    } else if (
      updatedBooking.modifiedCount === 0 &&
      updatedBooking.matchedCount > 0
    ) {
      res.status(204).json({});
    } else {
      res.status(404).json({
        request: "unsuccessful",
        error: {
          code: errorCodes.NOT_FOUND,
          name: "bookingNotFound",
          message: "The following booking does not exist.",
          logs: "",
        },
        data: {},
      });
    }
  } catch (err) {
    serverErrorResponse(err, errorCodes.SERVER_ERROR);
  }
};
