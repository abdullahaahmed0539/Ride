const mongoose = require("mongoose");

const bookingSchema = new mongoose.Schema({
  riderId: {
    type: String,
    require: [true, "Rider id is required."],
    unique: true,
    trim: true,
  },
  driverId: {
    type: String,
    require: [true, "Driver id is required."],
    unique: true,
    trim: true,
  },
  bookingTime: {
    type: Date,
    require: [true, "Booking time is required."],
    trim: true,
  },
  pickup: {
    type: String,
    require: [true, "Pickup is required."],
    trim: true,
  },
  dropoff: {
    type: String,
    require: [true, "Drop off is required."],
    trim: true,
  },
  status: {
    type: String,
    require: [true, "Status is required."],
    trim: true,
  },
});

const Booking = mongoose.model("Trip", bookingSchema);

module.exports = Booking;
