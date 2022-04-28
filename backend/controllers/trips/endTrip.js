const Trip = require("../../models/Trips");
const Booking = require("../../models/Bookings");
const Driver = require("../../models/Drivers");
const {
  onMissingValResponse,
  serverErrorResponse,
  onCreationResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");
const { calculateTotal, calculateTravellingCost, calculateWaitTime } = require("../../helper/pricing");

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
    const milage = (await Driver.findOne({_id: booking.driverId}).select('milage')).milage
    const trip = await Trip.findOne({ bookingId });
    const endTime = Date.now();
    const tripDetails = {
      endTime,
      duration: endTime - trip.startTime,
      distance: distance / 1000,
      fuelCost: process.env.FUEL_PRICE,
      disputeCost: process.env.DISPUTE_COST,
      milesCost: calculateTravellingCost(distance, milage),
      waitTimeCost: calculateWaitTime(trip.waitTime.getTime() / (1000 * 60)),
      waitTimeCostPerMin: process.env.WAIT_TIME_COST_PER_MIN,
      total: calculateTotal(
        distance,
        milage,
        trip.waitTime.getTime() / (1000 * 60),
      ),
    };
    await Trip.updateOne({ bookingId }, tripDetails);
    await Booking.updateOne({ _id: bookingId }, { status: "completed" });
    await Driver.updateOne({ _id: driverId }, { isBusy: false });
    onCreationResponse(res, {tripDetails});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
