const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");
const {
  onMissingValResponse,
  serverErrorResponse,
  onCreationResponse,
} = require("../../helper/responses");

const errorCodes = {
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  NOT_FOUND: "NOT_FOUND",
};

exports.setArrived = async (req, res) => {
  const { bookingId } = req.body;
  if (!bookingId) {
    onMissingValResponse(res, errorCodes.MISSING_VAL, "Booking id is missing.");
    return;
  }

  const newTrip = Trip({
    bookingId,
    driverArrivalTime: Date.now(),
  });

  try {
    await newTrip.save();
    await Booking.updateOne(
      { bookingId, status: "waiting" },
      { status: "arrived" }
    );
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
