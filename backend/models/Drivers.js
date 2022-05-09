const mongoose = require("mongoose");

const driverSchema = new mongoose.Schema({
  userId: {
    type: String,
    require: [true, "User id is required."],
    unique: true,
    trim: true,
  },
  licenseURL: {
    type: String,
    require: [true, "User id is required."],
    trim: true,
  },
  carRegistrationURL: {
    type: String,
    require: [true, "User id is required."],
    trim: true,
  },
  cnic: {
    type: String,
    require: [true, "CNIC number is required."],
    unique: true,
    trim: true,
  },
  carModel: {
    type: String,
    require: [true, "Car model is required."],
    trim: true,
  },
  milage: {
    type: Number,
    require: [true, "milage is required."],
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
  ratings: { type: [Number], required: [true, "rating is required."] },
  isActive: {
    type: Boolean,
    require: [true, "Is active is required."],
  },
  isBusy: {
    type: Boolean,
    require: [true, "Is busy  is required."],
  },
});

const Driver = mongoose.model("Driver", driverSchema);

module.exports = Driver;
