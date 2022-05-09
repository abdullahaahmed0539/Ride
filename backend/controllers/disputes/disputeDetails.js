const Dispute = require("../../models/Disputes");
const {errorCodes} = require("../../helper/errorCodes");

const {
  serverErrorResponse,
  notFoundResponse,
  successfulGetResponse,
} = require("../../helper/responses");

exports.disputeDetails = async (req, res) => {
  const _id = req.params.id;

  try {
    const disputeDetails = await Dispute.findOne({ _id });
    if (disputeDetails) {
      successfulGetResponse(res, {
        disputeDetails,
      });
    } else {
      notFoundResponse(
        res,
        errorCodes.DISPUTE_NOT_FOUND,
        "disputeNotFound",
        "The following dispute does not exist."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
