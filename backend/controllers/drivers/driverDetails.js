const Driver = require("../../models/Drivers");
const User = require("../../models/Users");
const {errorCodes} = require("../../helper/errorCodes");
const {
  onMissingValResponse,
  successfulGetResponse,
  notFoundResponse,
  serverErrorResponse,
} = require("../../helper/responses");

exports.driverDetails = async (req, res) => {
    const { driverId } = req.body;
  if (!driverId) {
    onMissingValResponse(res, errorCodes.MISSING_VAL, "Driver id is missing.");
    return;
  }

  try {
    const driverDetails = await Driver.findById({ _id: driverId }).select(
      "-cnic -licenseURL -carRegistrationURL -isActive -isBusy"
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
        milage: driverDetails.milage,
        ratings: driverDetails.ratings,
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
