const Dispute = require("../../models/Disputes");
const {
  serverErrorResponse,
  onMissingValResponse,
  onCreationResponse,
} = require("../../helper/responses");

const errorCodes = {
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.createDispute = async (req, res) => {
  const {
    initiatorId,
    defenderId,
    subject,
    shortDescription,
    initiatorsClaim,
  } = req.body;
  if (
    !initiatorId ||
    !defenderId ||
    !subject ||
    !shortDescription ||
    !initiatorsClaim
  ) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Either initiator id, rider's id, driver's id, subject or initiators claim is missing."
    );
    return;
  }

  const newDispute = Dispute({
    initiatorId,
    defenderId,
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
