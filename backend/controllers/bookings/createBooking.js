const Booking = require("../../models/Bookings");

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
    res.status(500).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.SERVER_ERROR,
        name: err.name,
        message: err.message,
        logs: err,
      },
      data: {},
    });
    return;
  }

  if (!riderId || !pickup || !dropoff) {
    res.status(406).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.MISSING_VAL,
        name: "missingVal",
        message: "Either riderId, pickup or dropoff is missing.",
        logs: "",
      },
      data: {},
    });
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
    res.status(201).json({
      request: "successful",
      error: {},
      data: {},
    });
  } catch (err) {
    res.status(500).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.SERVER_ERROR,
        name: err.name,
        message: err.message,
        logs: err,
      },
      data: {},
    });
  }
};
