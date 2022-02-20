const Request = require("../../models/Requests");
const {
  onMissingValResponse,
  onCreationResponse,
  serverErrorResponse,
  incorrectFormatResponse,
} = require("../../helper/responses");
const { validateCNIC } = require("../../helper/validators");

exports.createOnBoardingRequest = async (req, res) => {
  const { userId, cnic, carModel, color, registrationNumber } = req.body;
  if (!userId || !cnic || !carModel || !color || !registrationNumber) {
    onMissingValResponse(
      res,
      "MISSING_VALUE",
      "User id, cnic, car model, color or registration number is missing."
    );
    return;
  }

  if (!validateCNIC(cnic)) {
    incorrectFormatResponse(
      res,
      "INCORRECT_FORMAT",
      "Incorrect format",
      "CNIC is not in correct format."
    );
    return;
  }

  //add s3 links here
  const onBoardingRequest = Request({
    userId,
    cnic,
    licenseURL: "dummy",
    carRegistrationURL: "dummy",
    carModel,
    color,
    registrationNumber,
    status: "pending",
  });

  try {
    const anyPreviousPendingOrApprovedRequest = await Request.findOne({
      userId,
      $or: [
        {
          status: "pending",
        },
        {
          status: "approved",
        },
      ],
    });
    if (anyPreviousPendingOrApprovedRequest) {
      res.status(406).json({
        request: "unsuccessful",
        error: {
          code: "REQUEST_ALREADY_MADE",
          name: "MultipleRequests.",
          message: "Request already made.",
          logs: "",
        },
        data: {},
      });
      return;
    }
    const request = await onBoardingRequest.save();
    onCreationResponse(res, { request });
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
