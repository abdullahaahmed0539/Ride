const mongoose = require("mongoose");

const tripSchema = new mongoose.Schema({
  bookingId: {
    type: String,
    require: [true, "User id is required."],
    unique: true,
    trim: true,
  },
  distance: {
    type: Number,
  },
  startTime: {
    type: Date,
  },
  endTime: {
    type: Date,
  },
  duration: {
    type: Date,
  },
  driverArrivalTime: {
    type: Date,
  },
  waitTime: {
    type: Date,
  },
  total: {
    type: Number,
  },
  riderRating: {
    type: Number,
  },
  driverRating: {
    type: Number,
  },
});

const Trip = mongoose.model("Trip", tripSchema);

module.exports = Trip;
