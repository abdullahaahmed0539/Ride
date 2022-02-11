const Dispute = require("../../models/Disputes");

const errorCodes = {
  NOT_FOUND: "DISPUTE_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.addMyClaim = async (req, res) => {
  const { dispute_id, defendentsClaim } = req.body;

  if (!defendentsClaim) {
    res.status(406).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.MISSING_VAL,
        name: "missingVal",
        message: "Defendent's claim is missing.",
        logs: "",
      },
      data: {},
    });
  }

  try {
    const AddMyClaim = await Dispute.updateOne(
      { _id: dispute_id },
      { defendentsClaim, status: "active" }
    );

    if (AddMyClaim.modifiedCount > 0) {
      res.status(201).json({
        request: "successful",
        error: {},
        data: {
          dispute_id,
          updated_defendents_claim: defendentsClaim,
        },
      });
    } else if (AddMyClaim.modifiedCount === 0 && AddMyClaim.matchedCount > 0) {
      res.status(204).json({});
    } else {
      res.status(404).json({
        request: "unsuccessful",
        error: {
          code: errorCodes.NOT_FOUND,
          name: "DisputeNotFound",
          message: "The following dispute does not exist.",
          logs: "",
        },
        data: {},
      });
    }
  } catch (err) {
    res.status(500).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.SERVER_ERROR,
        name: err.name,
        message: err.message,
        logs: err,
      },
      data: {},
    });
  }
};
