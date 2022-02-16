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

  total: {
    type: Number,
  },
  rating: {
    type: Number,
  },
});

const Trip = mongoose.model("Trip", tripSchema);

module.exports = Trip;
