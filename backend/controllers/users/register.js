const User = require("../../models/Users");
const { validateUserInfo, validateMetamask } = require("../../helper/validators");
const { errorCodes } = require("../../helper/errorCodes");

const {
  serverErrorResponse,
  onCreationResponse,
  onMissingValResponse,
  notUniqueResponse,
  incorrectFormatResponse,
} = require("../../helper/responses");

exports.register = async (req, res) => {
  const { phoneNumber, country, firstName, lastName, email, walletAddress } =
    req.body;

  //check if neccessary attributes are available.
  if (
    !phoneNumber ||
    !country ||
    !firstName ||
    !lastName ||
    !email ||
    !walletAddress
  ) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "phoneNumber, country, firstName, lastName, email or walletAddress is missing."
    );
    return;
  }

  //validate format
  if (!validateUserInfo(email, phoneNumber, country) || !validateMetamask(walletAddress)) {
    incorrectFormatResponse(
      res,
      errorCodes.INCORRECT_FORMAT,
      "FormatError",
      "Either phone number, metamask wallet or email is invalid"
    );
    return;
  } 
  
  //creating a new user
  const newUser = new User({
    phoneNumber,
    country,
    firstName,
    lastName,
    email,
    walletAddress,
    isDriver: false,
    rating: [],
  });

  try {
    //save the user in db and sending response
    const user = await newUser.save();
    const data = {
      _id: user._id,
      phoneNumber: user.phoneNumber,
      country: user.country
    }
    onCreationResponse(res, data);
  } catch (err) {
    //Error handling for not unique or any other server error
    err.name === "MongoServerError" && err.code === 11000
      ? notUniqueResponse(res, err, errorCodes.NOT_UNIQUE)
      : serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
