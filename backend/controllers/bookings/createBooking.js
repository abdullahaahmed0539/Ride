const Booking = require("../../models/Bookings");
const User = require("../../models/Users");
const Driver = require("../../models/Drivers");
const {errorCodes} = require("../../helper/errorCodes");
const {
  serverErrorResponse,
  onMissingValResponse,
  onCreationResponse,
  unAuthorizedResponse,
  notFoundResponse,
} = require("../../helper/responses");


exports.createBooking = async (req, res) => {
  const { riderId, driverId, pickup, dropoff} = req.body;
  if (!riderId || !pickup || !dropoff || !driverId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Either riderId, pickup, driverId or dropoff is missing."
    );
    
    return;
  }

  try {
    const user = await User.findById({_id: riderId});
    if (!user) {
      notFoundResponse(
        res,
        errorCodes.USER_NOT_FOUND,
        "USER_NOT_FOUND",
        "No user against the following id"
      );
      return;
    }
    
    //making sure not more than 1 bookings are scheduled at one time
    const bookingAlreadyMade = await Booking.find({
      riderId,
      $or: [
        {
          status: "accepted",
        },
        {
          status: "inprogress",
        },
      ],
    });

    if (bookingAlreadyMade.length > 0) {
      res.status(406).json({
        request: "unsuccessful",
        error: {
          code: errorCodes.BOOKING_ALREADY_MADE,
          name: "Booking already made.",
          message: "You already have an ongoing ride.",
          logs: "",
        },
        data: {},
      });
      return;
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
    return;
  }

  const driverDetails = await Driver.findById({ _id: driverId }).select(
    "userId isActive isBusy"
  );
  if (
    !driverDetails.isActive ||
    (driverDetails.isActive && driverDetails.isBusy)
  ) {
    unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
    return;
  }

  const riderIsDriver = await Driver.findOne({
    _id: driverId,
    userId: riderId,
  });
  if (riderIsDriver) {
    unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
    return;
  }

  const newBooking = Booking({
    riderId,
    driverId,
    pickup,
    dropoff,
    bookingTime: new Date(),
    status: "accepted",
  });

  try {
    await newBooking.save();
    await Driver.updateOne({ _id: driverId }, { isBusy: true });
    onCreationResponse(res, {booking: newBooking});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
