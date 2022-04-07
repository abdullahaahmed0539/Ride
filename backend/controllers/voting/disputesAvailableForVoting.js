const Dispute = require("../../models/Disputes");
const {
  serverErrorResponse,
  notFoundResponse,
  successfulGetResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "DISPUTE_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.disputesAvailableForVoting = async (req, res) => {
    const userId = req.params.id;

    try {
        const disputes = await Dispute.find({
          initiatorId: { $ne: userId },
          defenderId: { $ne: userId },
          votedBy: { $ne: userId },
          status: "active",
        });
      
      if (disputes.length === 0 ) {
        notFoundResponse(
          res,
          errorCodes.NOT_FOUND,
          "disputesNotFound",
          "There are no disputes."
        );
      } else {
        successfulGetResponse(res, {
          disputes,
        });
      }
    } catch (err) {
      serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
    }
}