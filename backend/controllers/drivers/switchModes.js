const Driver = require("../../models/Drivers");
const {
  onMissingValResponse,
  notFoundResponse,
  onCreationResponse,
  serverErrorResponse,
} = require("../../helper/responses");

exports.switchModes = async (req, res) => {
  const { userId, appMode } = req.body;
  if (!userId || !appMode) {
    onMissingValResponse(res, "MISSING_VALUE", "User id or app mode is missing.");
    return;
  }

  try {
    const driver = await Driver.findOne({ userId }).select("isActive");
    if (!driver) {
      notFoundResponse(
        res,
        "NOT_FOUND",
        "DRIVER_NOT_FOUND",
        "There is no driver with the following user id."
      );
      return;
    }
    let isActive = false;
    if (appMode === 'rider') {
      isActive = true;
    }
    await Driver.updateOne({ userId }, { isActive });
    const driverDetails = await Driver.findOne({ userId }).select(
      "-licenseURL -carRegistrationURL"
    );
    onCreationResponse(res, {
      driverDetails,
    });
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
