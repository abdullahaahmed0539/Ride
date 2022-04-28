const mongoose = require("mongoose");

const requestSchema = new mongoose.Schema({
  userId: {
    type: String,
    require: [true, "User id is required."],
    unique: true,
    trim: true,
  },
  cnic: {
    type: String,
    require: [true, "CNIC number is required."],
    unique: true,
    trim: true,
  },
  milage: {
    type: Number,
    require: [true, "milage is required."],
  },
  licenseURL: {
    type: String,
    require: [true, "User id is required."],
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
  decisionDate: {
    type: Date,
    trim: true,
  },
  status: {
    type: String,
    require: [true, "approve is required."],
    trim: true,
  },
});

const Request = mongoose.model("Request", requestSchema);

module.exports = Request;
