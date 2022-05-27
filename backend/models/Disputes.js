const mongoose = require("mongoose");

const disputeSchema = new mongoose.Schema({
  initiatorId: {
    type: String,
    require: [true, "Initiator id is required."],
    trim: true,
  },
  defenderId: {
    type: String,
    require: [true, "defender id is required."],
    trim: true,
  },
  subject: {
    type: String,
    require: [true, "Subject is required."],
    trim: true,
  },
  shortDescription: {
    type: String,
    require: [true, "Short description is required."],
    trim: true,
  },
  initiatorsClaim: {
    type: String,
    trim: true,
  },
  defendentsClaim: {
    type: String,
    trim: true,
  },
  initiatorsVote: {
    type: Number,
    require: [true, "Riders vote is required."],
  },
  defendentsVote: {
    type: Number,
    require: [true, "Riders vote is required."],
  },
  publishedOn: {
    type: Date,
    require: [true, "Publishing date is required."],
    trim: true,
  },
  amount: {
    type: Number,
    require: [true, "Riders vote is required."],
  },
  status: {
    type: String,
    require: [true, "Status is required."],
    trim: true,
  },
  votedBy: { type: [String] },
});

const Dispute = mongoose.model("Dispute", disputeSchema);

module.exports = Dispute;
