const Booking = require("../../models/Bookings");
const Driver = require("../../models/Drivers");
const {
  serverErrorResponse,
  onCreationResponse,
  notFoundResponse,
  onMissingValResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "BOOKING_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  MISSING_VAL: "MISSING_VALUE",
};

exports.acceptBooking = async (req, res) => {
  const { bookingId, driverId } = req.body;

  if (!bookingId || !driverId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Bookinf id or driver id is missing."
    );
    return;
  }

  try {
    const driverStatus = await Driver.findById({ _id: driverId }).select(
      "isActive isBusy"
    );
    if (
      !driverStatus.isActive ||
      (driverStatus.isActive && driverStatus.isBusy)
    ) {
      unAuthorizedResponse(res, "FORBIDDEN");
      return;
    }
    const updatedBooking = await Booking.updateOne(
      { _id: bookingId, status: "insearch" },
      { driverId, status: "waiting" }
    );
    if (updatedBooking.modifiedCount > 0) {
      await Driver.updateOne({ _id: driverId }, { isBusy: true });
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
