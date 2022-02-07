const mongoose = require("mongoose");

const disputeSchema = new mongoose.Schema({
  initiatorId: {
    type: String,
    require: [true, "Initiator id is required."],
    trim: true,
  },
  riderId: {
    type: String,
    require: [true, "Rider id is required."],
    trim: true,
  },
  driverId: {
    type: String,
    require: [true, "Driver id is required."],
    trim: true,
  },
  subject: {
    type: String,
    require: [true, "Subject is required."],
    trim: true,
  },
  ridersClaim: {
    type: String,
    trim: true,
  },
  driversClaim: {
    type: String,
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
  publishedOn: {
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
