const Driver = require("../../models/Drivers");
const {
  onMissingValResponse,
  notFoundResponse,
} = require("../../helper/responses");

exports.switchModes = async (req, res) => {
  const { userId } = req.body;
  if (!userId) {
    onMissingValResponse(res, "MISSING_VALUE", "User id is missing.");
    return;
  }

  try {
    const user = await Driver.findOne({ userId });
    if (!user) {
      notFoundResponse(
        res,
        "NOT_FOUND",
        "DRIVER_NOT_FOUND",
        "There is no driver with the following user id."
      );
      return;
    }
  } catch (err) {}
};
