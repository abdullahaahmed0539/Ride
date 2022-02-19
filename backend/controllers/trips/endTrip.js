const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");
const {
  onMissingValResponse,
  serverErrorResponse,
  onCreationResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");
const { calculateTotal } = require("../../helper/calculateTotal");

const errorCodes = {
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  UNAUTHORIZED: "UNAUTHORIZED_ACCESS",
};

exports.endTrip = async (req, res) => {
  const { bookingId, driverId, distance } = req.body;
  if (!bookingId || !driverId || !distance) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Either booking id, driver id or distance travelled is missing."
    );
  }
  try {
    const booking = await Booking.findOne({
      _id: bookingId,
      driverId,
      status: "inprogress",
    });
    if (!booking) {
      unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
      return;
    }
    const trip = await Trip.findOne({ bookingId });
    const endTime = Date.now();
    const tripDetails = {
      endTime,
      duration: endTime - trip.startTime,
      distance,
      total: calculateTotal(distance),
    };
    await Trip.updateOne({ bookingId }, tripDetails);
    await Booking.updateOne({ _id: bookingId }, { status: "completed" });
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
