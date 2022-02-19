const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");

const {
  serverErrorResponse,
  onMissingValResponse,
  notFoundResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");

const errorCodes = {
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  NOT_FOUND: "TRIP_NOT_FOUND",
  UNAUTHORIZED: "UNAUTHORIZED_ACCESS",
};

exports.tripDetails = async (req, res) => {
  const { bookingId, userId } = req.body;
  if (!bookingId || !userId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Booking id or user id is missing."
    );
    return;
  }

  try {
    const booking = await Booking.findOne({
      _id: bookingId,
      riderId: userId,
    });
    if (!booking) {
      unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
      return;
    }

    const trip = await Trip.findOne({ bookingId });
    if (!trip) {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "TRIP_NOT_FOUND",
        "There are no trips with the booking id provided."
      );
    } else {
      res.status(200).json({
        request: "successful",
        error: {},
        data: {
          trip,
        },
      });
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
