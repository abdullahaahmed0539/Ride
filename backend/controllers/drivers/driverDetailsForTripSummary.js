const Driver = require("../../models/Drivers");
const User = require("../../models/Users");
const Booking = require("../../models/Bookings");
const {errorCodes} = require("../../helper/errorCodes");
const {
  onMissingValResponse,
  successfulGetResponse,
  notFoundResponse,
  serverErrorResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");

exports.driverDetailsForTrip = async (req, res) => {
  const { driverId, bookingId, riderId } = req.body;
  if (!driverId || !bookingId || !riderId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Driver id, rider id or booking id is missing."
    );
    return;
  }

  try {
    const booking = await Booking.findOne({
      _id: bookingId,
      driverId,
      riderId,
    });
    if (!booking) {
      unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
      return;
    }
    const driverDetails = await Driver.findById({ _id: driverId }).select(
      "userId carModel color registrationNumber"
    );
    const userDetails = await User.findById({
      _id: driverDetails.userId,
    }).select("firstName lastName phoneNumber -_id");

    if (driverDetails && userDetails) {
      const driver = {
        _id: driverDetails._id,
        firstName: userDetails.firstName,
        lastName: userDetails.lastName,
        phoneNumber: userDetails.phoneNumber,
        carModel: driverDetails.carModel,
        color: driverDetails.color,
        registrationNumber: driverDetails.registrationNumber,
      };
      successfulGetResponse(res, { driver });
    } else {
      notFoundResponse(
        res,
        errorCodes.DRIVER_NOT_FOUND,
        "DriverNotFound",
        "There is no driver with the id provided."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
