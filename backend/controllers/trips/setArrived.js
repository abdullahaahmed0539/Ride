const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");
const { errorCodes } = require("../../helper/errorCodes");
const {
  onMissingValResponse,
  serverErrorResponse,
  onCreationResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");

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
      status: "accepted",
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
