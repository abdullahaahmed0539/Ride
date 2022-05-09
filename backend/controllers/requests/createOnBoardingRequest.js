const Request = require("../../models/Requests");
const {
  onMissingValResponse,
  onCreationResponse,
  serverErrorResponse,
  incorrectFormatResponse,
} = require("../../helper/responses");
const { validateCNIC } = require("../../helper/validators");
const { errorCodes } = require("../../helper/errorCodes");

exports.createOnBoardingRequest = async (req, res) => {
  const {
    userId,
    cnic,
    carModel,
    color,
    registrationNumber,
    milage,
    licenseURL,
    
  
  } = req.body;
  if (!userId || !cnic || !carModel || !color || !registrationNumber || !milage) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "User id, cnic, car model, milage, color or registration number is missing."
    );
    return;
  }

  if (!validateCNIC(cnic)) {
    incorrectFormatResponse(
      res,
      errorCodes.INCORRECT_FORMAT,
      "Incorrect format",
      "CNIC is not in correct format."
    );
    return;
  }

  const onBoardingRequest = Request({
    userId,
    cnic,
    licenseURL,
    carModel,
    color,
    milage,
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
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
