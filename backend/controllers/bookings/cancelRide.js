const Booking = require("../../models/Bookings");
const Driver = require("../../models/Drivers");
const {
  serverErrorResponse,
  onMissingValResponse,
  onCreationResponse,
  notFoundResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "BOOKING_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  MISSING_VAL: "MISSING_VALUE",
  UNAUTHORIZED: "UNAUTHORIZED_ACCESS",
};

exports.riderCancellation = async (req, res) => {
  const { bookingId, riderId } = req.body;

  if (!bookingId || !riderId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Booking id or rider id is missing."
    );
  }

  try {
    const booking = await Booking.findOne({
      _id: bookingId,
      $or: [{ status: "insearch" }, { status: "waiting" }],
    }).select("riderId");

    if (!booking) {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "bookingNotFound",
        "The following booking does not exist."
      );
      return;
    } else if (booking.riderId !== riderId) {
      unAuthorizedResponse(res, errorCodes.unAuthorizedResponse);
      return;
    }

    const updatedBooking = await Booking.updateOne(
      { _id: bookingId },
      { status: "cancelled" }
    );
    if (updatedBooking.modifiedCount > 0) {
      if (booking.driverId) {
        await Driver.updateOne({ _id: driverId }, { isBusy: false });
      }
      onCreationResponse(res, {
        bookingId,
        status: "cancelled",
      });
    } else if (
      updatedBooking.modifiedCount === 0 &&
      updatedBooking.matchedCount > 0
    ) {
      res.status(204).json({});
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};

exports.driverCancellation = async (req, res) => {
  const { bookingId, driverId } = req.body;

  if (!bookingId || !driverId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Booking id or driver id is missing."
    );
  }

  try {
    const booking = await Booking.findOne({
      _id: bookingId,
      status: "waiting",
    }).select("driverId");
    if (!booking) {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "bookingNotFound",
        "The following booking does not exist."
      );
      return;
    } else if (booking.driverId !== driverId) {
      unAuthorizedResponse(res, errorCodes.unAuthorizedResponse);
      return;
    }
    const updatedBooking = await Booking.updateOne(
      { _id: bookingId },
      { driverId: null, status: "insearch" }
    );
    if (updatedBooking.modifiedCount > 0) {
      await Driver.updateOne({ _id: driverId }, { isBusy: false });
      onCreationResponse(res, {
        bookingId,
        status: "cancelled",
      });
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
