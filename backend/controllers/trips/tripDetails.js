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
  const { bookingId, userId, driverMode } = req.body;
  if (!bookingId || !userId || driverMode) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Booking id, driver mode or user id is missing."
    );
    return;
  }

  try {
    let userDetail;
    if (driverMode) {
      userDetail = {
        _id: bookingId,
        driverId: userId,
      };
    } else {
      userDetail = {
        _id: bookingId,
        riderId: userId,
      };
    }
    const booking = await Booking.findOne(userDetail);
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
