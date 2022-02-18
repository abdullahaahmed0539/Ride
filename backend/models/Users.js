const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  firstName: {
    type: String,
    required: [true, "First name is required."],
    trim: true,
  },
  lastName: {
    type: String,
    required: [true, "Last name is required."],
    trim: true,
  },
  email: {
    type: String,
    required: [true, "Email is required."],
    unique: true,
    trim: true,
  },
  phoneNumber: {
    type: String,
    required: [true, "Phone number is required."],
    unique: true,
    trim: true,
  },
  country: {
    type: String,
    required: [true, "Country is required."],
    trim: true,
  },
  walletAddress: {
    type: String,
    required: [true, "Wallet address is required."],
    trim: true,
  },
  walletHash: {
    type: String,
    required: [true, "Wallet hash is required."],
    unique: true,
    trim: true,
  },
  isDriver: {
    type: Boolean,
    required: [true, "isDriver is required."],
  },
  ratings: { type: [Number], required: [true, "rating is required."] },
  creditCard: {
    type: String,
    trim: true,
  },
});

const User = mongoose.model("User", userSchema);

module.exports = User;
