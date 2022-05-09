const Disputes = require("../../models/Disputes");
const {errorCodes} = require("../../helper/errorCodes");

const {
  serverErrorResponse,
  notFoundResponse,
  successfulGetResponse,
} = require("../../helper/responses");

exports.disputesOnMe = async (req, res) => {
  const userId = req.params.id;

  try {
    const disputes = await Disputes.find({ defenderId: userId });
    if (disputes.length === 0) {
      notFoundResponse(
        res,
        errorCodes.DISPUTE_NOT_FOUND,
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
