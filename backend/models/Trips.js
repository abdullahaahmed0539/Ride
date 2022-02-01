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
    require: [true, "Distance is required."],
  },
  waitTime: {
    type: Number,
    require: [true, "Wait time is required."],
  },
  timeInTraffic: {
    type: Number,
    require: [true, "Time in traffic is required."],
  },
  total: {
    type: Number,
    require: [true, "Total is required."],
  },
  rating: {
    type: Number,
    require: [true, "Rating is required."],
  },
});

const Trip = mongoose.model("Trip", tripSchema);

module.exports = Trip;
