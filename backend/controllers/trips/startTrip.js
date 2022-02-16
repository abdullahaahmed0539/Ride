const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");

const {
  serverErrorResponse,
  onMissingValResponse,
  onCreationResponse,
} = require("../../helper/responses");

const errorCodes = {
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.startTrip = async (req, res) => {
  const bookingId = req.body.booking_id;

  if (!bookingId) {
    onMissingValResponse(res, errorCodes.MISSING_VAL, "Booking Id is missing.");
    return;
  }

  const newTrip = Trip({
    bookingId,
    startTime: Date.now(),
  });

  try {
    await newTrip.save();
    await Booking.updateOne({ bookingId }, { status: "inprogress" });
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
