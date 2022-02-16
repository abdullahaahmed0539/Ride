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
      onCreationResponse(res, {
        bookingId,
        driverId,
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
