const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");

const {
  serverErrorResponse,
  onMissingValResponse,
  onCreationResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");

const errorCodes = {
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  UNAUTHORIZED: "UNAUTHORIZED_ACCESS",
};

exports.startTrip = async (req, res) => {
  const { bookingId, driverId } = req.body;

  if (!bookingId || !driverId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Booking Id or driver id is missing."
    );
    return;
  }

  const startTime = Date.now();
  try {
    const booking = await Booking.findOne({
      _id: bookingId,
      driverId,
      status: "arrived",
    });
    if (!booking) {
      unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
      return;
    }
    const trip = await Trip.findOne({ bookingId }).select("driverArrivalTime");
    const updatedAttr = {
      startTime,
      waitTime: startTime - trip.driverArrivalTime,
    };

    await Trip.updateOne({ bookingId }, updatedAttr);
    await Booking.updateOne({ _id: bookingId }, { status: "inprogress" });
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
