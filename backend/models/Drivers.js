const mongoose = require("mongoose");

const driverSchema = new mongoose.Schema({
  userId: {
    type: String,
    require: [true, "User id is required."],
    unique: true,
    trim: true,
  },
  carModel: {
    type: String,
    require: [true, "Car model is required."],
    trim: true,
  },
  color: {
    type: String,
    require: [true, "Car color is required."],
    trim: true,
  },
  registrationNumber: {
    type: String,
    require: [true, "Registration number is required."],
    unique: true,
    trim: true,
  },
  rating: {
    type: Number,
    require: [true, "Rating is required."],
  },
  isActive: {
    type: Boolean,
    require: [true, "Is active  is required."],
  },
  isBusy: {
    type: Boolean,
    require: [true, "Is busy  is required."],
  },
});

const Driver = mongoose.model("Driver", driverSchema);

module.exports = Driver;
