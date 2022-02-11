const Booking = require("../../models/Bookings");

const errorCodes = {
  NOT_FOUND: "BOOKING_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.acceptBooking = async (req, res) => {
  const { bookingId, driverId } = req.body;

  try {
    const updatedBooking = await Booking.updateOne(
      { _id: bookingId },
      { driverId, status: "waiting" }
    );
    if (updatedBooking.modifiedCount > 0) {
      /*
          
          Add code related to driver busy now
          
          */
      res.status(201).json({
        request: "successful",
        error: {},
        data: {
          bookingId,
          driverId,
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
    res.status(500).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.SERVER_ERROR,
        name: err.name,
        message: err.message,
        logs: err,
      },
      data: {},
    });
  }
};
