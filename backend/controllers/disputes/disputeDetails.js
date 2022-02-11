const Dispute = require("../../models/Disputes");

const errorCodes = {
  NOT_FOUND: "DISPUTE_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.disputeDetails = async (req, res) => {
  const _id = req.params.id;

  try {
    const disputeDetails = await Dispute.findOne({ _id });
    if (disputeDetails) {
      res.status(200).json({
        request: "successful",
        error: {},
        data: {
          disputeDetails,
        },
      });
    } else {
      res.status(404).json({
        request: "unsuccessful",
        error: {
          code: errorCodes.NOT_FOUND,
          name: "disputeNotFound",
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
