const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  firstName: {
    type: String,
    require: [true, "First name is required."],
    trim: true,
  },
  lastName: {
    type: String,
    require: [true, "Last name is required."],
    trim: true,
  },
  email: {
    type: String,
    require: [true, "Email is required."],
    unique: true,
    trim: true,
  },
  phoneNumber: {
    type: String,
    require: [true, "Phone number is required."],
    unique: true,
    trim: true,
  },
  country: {
    type: String,
    require: [true, "Country is required."],
    trim: true,
  },
  walletAddress: {
    type: String,
    require: [true, "Wallet address is required."],
    unique: true,
    trim: true,
  },
  isDriver: {
    type: Boolean,
    require: [true, "isDriver is required."],
  },
  rating: {
    type: Number,
    require: [true, "Rating is required."],
  },
  creditCard: {
    type: String,
    unique: true,
    trim: true,
  },
});

const User = mongoose.model("User", userSchema);

module.exports = User;
