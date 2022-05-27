const Dispute = require("../../models/Disputes");
const Driver = require("../../models/Drivers");
const User = require("../../models/Users");
const { errorCodes } = require("../../helper/errorCodes");//
const { collectDisputeAmount } = require("../../blockchain/callingBlockchain");
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
    amount
  } = req.body;
  let { defenderId } = req.body
  if (
    !initiatorId ||
    !defenderId ||
    !subject ||
    !shortDescription ||
    !initiatorsClaim ||
    !amount ||
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
      const driver = await Driver.findById({ _id: defenderId }).select(
        "userId"
      );
      defenderId = driver.userId;
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
    amount,
    publishedOn: new Date(),
    status: "pending",
  });

  try {
    const initiatorWalletAddress = (await User.findById({ _id: initiatorId }).select('walletAddress')).walletAddress
    const defendentWalletAddress = (await User.findById({ _id: defenderId }).select('walletAddress')).walletAddress
    await collectDisputeAmount(
      initiatorWalletAddress,
      Math.ceil(amount / 2),
      defendentWalletAddress
    );
    await newDispute.save();
    onCreationResponse(res, {});
    console.log(err)
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
