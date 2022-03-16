const jwt = require("jsonwebtoken");
const User = require("../../models/Users");
const {
  serverErrorResponse,
  onMissingValResponse,
  notFoundResponse,
  successfulGetResponse,
} = require("../../helper/responses");

exports.login = async (req, res) => {
  //storing values passed from client side
  const { phoneNumber } = req.body;
  if (!phoneNumber) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "phoneNumber is missing."
    );
    return;
  }

  try {
    const user = await User.findOne({ phoneNumber }).select("-walletHash");
    if (!user) {
      notFoundResponse(
        res,
        "USER_NOT_FOUND",
        "UserNotFound",
        "The following user does not exist."
      );
      return;
    } else {
      let token = jwt.sign({
        _id: user._id,
        phoneNumber: user.phoneNumber,
        isDriver: user.isDriver
      },process.env.TOKEN_KEY, {expiresIn:'1h'});
      const data = {
        _id: user._id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        country: user.country,
        walletAddress: user.walletAddress,
        isDriver: user.isDriver,
        ratings: user.ratings,
        token,
      };
      successfulGetResponse(res, data);
    }
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
