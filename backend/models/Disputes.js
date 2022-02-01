const mongoose = require("mongoose");

const disputeSchema = new mongoose.Schema({
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
  subject: {
    type: String,
    require: [true, "Subject is required."],
    trim: true,
  },
  description: {
    type: String,
    require: [true, "Description is required."],
    trim: true,
  },
  ridersVote: {
    type: Number,
    require: [true, "Riders vote is required."],
  },
  driversVote: {
    type: Number,
    require: [true, "Riders vote is required."],
  },
  datePublished: {
    type: Date,
    require: [true, "Publishing date is required."],
    trim: true,
  },
  status: {
    type: String,
    require: [true, "Status is required."],
    trim: true,
  },
});

const Dispute = mongoose.model("Dispute", disputeSchema);

module.exports = Dispute;
