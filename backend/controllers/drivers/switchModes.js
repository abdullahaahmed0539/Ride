const Driver = require("../../models/Drivers");
const {
  onMissingValResponse,
  notFoundResponse,
  onCreationResponse,
  serverErrorResponse,
} = require("../../helper/responses");

exports.switchModes = async (req, res) => {
  const { userId } = req.body;
  if (!userId) {
    onMissingValResponse(res, "MISSING_VALUE", "User id is missing.");
    return;
  }

  try {
    const user = await Driver.findOne({ userId }).select("isActive");
    if (!user) {
      notFoundResponse(
        res,
        "NOT_FOUND",
        "DRIVER_NOT_FOUND",
        "There is no driver with the following user id."
      );
      return;
    }
    await Driver.updateOne({ userId }, { isActive: !user.isActive });
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
