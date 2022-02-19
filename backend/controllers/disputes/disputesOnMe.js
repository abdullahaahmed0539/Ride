const Disputes = require("../../models/Disputes");
const {
  serverErrorResponse,
  notFoundResponse,
  successfulGetResponse,
} = require("../../helper/responses");

const errorCodes = {
  NOT_FOUND: "DISPUTE_NOT_FOUND",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.disputesOnMe = async (req, res) => {
  const userId = req.params.id;

  try {
    const disputes = await Disputes.find({ defenderId: userId });
    if (disputes.length === 0) {
      notFoundResponse(
        res,
        errorCodes.NOT_FOUND,
        "disputesNotFound",
        "There are no disputes on this user."
      );
    } else {
      successfulGetResponse(res, {
        disputes,
      });
    }
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
