const Dispute = require("../../models/Disputes");
const {
  serverErrorResponse,
  onMissingValResponse,
  onCreationResponse,
  notFoundResponse,
  unAuthorizedResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "DISPUTE_NOT_FOUND",
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  UNAUTHORIZED: "UNAUTHORIZED_ACCESS",
};

exports.addMyClaim = async (req, res) => {
  const { disputeId, defendentsClaim, userId } = req.body;

  if (!disputeId || !defendentsClaim || !userId) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Defendent's claim, dispute id or user id is missing."
    );
  }

  try {
    const dispute = await Dispute.findById({ _id: disputeId }).select("defenderId");
    if (dispute.defenderId !== userId) {
      unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
      return;
    }

    const AddMyClaim = await Dispute.updateOne(
      { _id: disputeId },
      { defendentsClaim, status: "active" }
    );

    if (AddMyClaim.modifiedCount > 0) {
      onCreationResponse(res, {
        disputeId,
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
    console.log(err)
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
