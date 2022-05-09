const Dispute = require("../../models/Disputes");
const Driver = require("../../models/Drivers");
const {errorCodes} = require("../../helper/errorCodes");
const {
  serverErrorResponse,
  onMissingValResponse,
  onCreationResponse,
} = require("../../helper/responses");

exports.createDispute = async (req, res) => {
  const {
    initiatorId,
    subject,
    shortDescription,
    initiatorsClaim,
    disputeBy,
  } = req.body;
  let { defenderId } = req.body
  if (
    !initiatorId ||
    !defenderId ||
    !subject ||
    !shortDescription ||
    !initiatorsClaim ||
    !disputeBy
  ) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Either initiator id, rider's id, driver's id, subject, dispute by or initiators claim is missing."
    );
    return;
  }

  if (disputeBy == "rider") {
    try {
      defenderId = (await Driver.findById({ _id: defenderId }).select("userId")).userId;
    } catch (error) {
      console.log(error.message);
    }
  }

  const newDispute = Dispute({
    initiatorId,
    defenderId: defenderId,
    subject,
    shortDescription,
    initiatorsClaim,
    initiatorsVote: 0,
    defendentsVote: 0,
    publishedOn: new Date(),
    status: "pending",
  });

  try {
    await newDispute.save();
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
