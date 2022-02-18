const Trip = require("../../models/Trips");

const {
  serverErrorResponse,
  onMissingValResponse,
  notFoundResponse,
} = require("../../helper/responses");

const errorCodes = {
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  NOT_FOUND: "TRIP_NOT_FOUND",
};

exports.tripDetails = async (req, res) => {
  const bookingId = req.body.booking_id;
  if (!bookingId) {
    onMissingValResponse(res, errorCodes.MISSING_VAL, "Booking id is missing.");
    return;
  }

  try {
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
