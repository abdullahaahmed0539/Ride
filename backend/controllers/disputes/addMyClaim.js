const Dispute = require("../../models/Disputes");
const {
  serverErrorResponse,
  onMissingValResponse,
  onCreationResponse,
  notFoundResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "DISPUTE_NOT_FOUND",
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.addMyClaim = async (req, res) => {
  const { dispute_id, defendentsClaim } = req.body;

  if (!defendentsClaim) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Defendent's claim is missing."
    );
  }

  try {
    const AddMyClaim = await Dispute.updateOne(
      { _id: dispute_id },
      { defendentsClaim, status: "active" }
    );

    if (AddMyClaim.modifiedCount > 0) {
      onCreationResponse({
        res,
        dispute_id,
        updated_defendents_claim: defendentsClaim,
      });
    } else if (AddMyClaim.modifiedCount === 0 && AddMyClaim.matchedCount > 0) {
      res.status(204).json({});
    } else {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "DisputeNotFound",
        "The following dispute does not exist."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
