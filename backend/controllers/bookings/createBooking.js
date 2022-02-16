const Booking = require("../../models/Bookings");
const {
  serverErrorResponse,
  onMissingValResponse,
  onCreationResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "BOOKING_NOT_FOUND",
  BOOKING_ALREADY_MADE: "BOOKING_ALREADY_MADE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.createBooking = async (req, res) => {
  const { riderId, pickup, dropoff } = req.body;

  try {
    const bookingAlreadyMade = await Booking.find({
      riderId,
      $or: [
        {
          status: "insearch",
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

  if (!riderId || !pickup || !dropoff) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Either riderId, pickup or dropoff is missing."
    );
    return;
  }

  const newBooking = Booking({
    riderId,
    pickup,
    dropoff,
    bookingTime: new Date(),
    status: "insearch",
  });

  try {
    await newBooking.save();
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
