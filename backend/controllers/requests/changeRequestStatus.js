const Request = require("../../models/Requests");
const Driver = require("../../models/Drivers");
const {
  onMissingValResponse,
  serverErrorResponse,
  notFoundResponse,
  onCreationResponse,
  onBadParameters,
} = require("../../helper/responses");
const { updateOne } = require("../../models/Requests");

exports.changeRequestStatus = async (req, res) => {
  const { _id, decision } = req.body;
  if (!_id || !decision) {
    onMissingValResponse(
      res,
      "MISSING_VAL",
      "Request id or decision is missing."
    );
    return;
  }

  try {
    const updatedStatus = await Request.updateOne(
      { _id, status: "pending" },
      { decisionDate: Date.now(), status: decision }
    );
    if (updatedStatus.modifiedCount > 0) {
      if (decision === "accepted") {
        const driverDetails = await Request.findById({ _id }).select(
          "-dateApproved -status"
        );
        const newDriver = Driver({
          userId: driverDetails.userId,
          licenseURL: driverDetails.licenseURL,
          carRegistrationDoc: driverDetails.carRegistrationDoc,
          cnic: driverDetails.cnic,
          carModel: driverDetails.carModel,
          color: driverDetails.color,
          registrationNumber: driverDetails.registrationNumber,
          rating: [],
          isActive: false,
          isBusy: false,
        });
        await newDriver.save();
      }
      onCreationResponse(res, {});
    } else {
      notFoundResponse(
        res,
        "NOT_FOUND",
        "RequestNotFOund",
        "The following request does not exist."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
