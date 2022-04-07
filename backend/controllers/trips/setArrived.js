const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");
const {
  onMissingValResponse,
  serverErrorResponse,
  onCreationResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");

const errorCodes = {
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  NOT_FOUND: "NOT_FOUND",
  UNAUTHORIZED: "UNAUTHORIZED_ACCESS",
};

exports.setArrived = async (req, res) => {
  const { bookingId, driverId } = req.body;
  if (!bookingId || !driverId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Booking id or driver id is missing."
    );
    return;
  }

  const newTrip = Trip({
    bookingId,
    driverArrivalTime: Date.now(),
 
  });

  try {
    const booking = await Booking.findOne({
      _id: bookingId,
      driverId,
      status: "waiting",
    });
    if (!booking) {
      unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
      return;
    }
    await newTrip.save();
    await Booking.updateOne({ _id: bookingId }, { status: "arrived" });
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
