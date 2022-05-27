const Dispute = require("../../models/Disputes");
const User = require("../../models/Users");
const { errorCodes } = require("../../helper/errorCodes");
const {disputeResult} = require('../../blockchain/callingBlockchain')

const {
  serverErrorResponse,
  onCreationResponse,
  unAuthorizedResponse,
  incorrectFormatResponse,
} = require("../../helper/responses");

exports.addVote = async (req, res) => {
  const { disputeId, userId, voteFor } = req.body;

  if (voteFor !== "1" && voteFor !== "0") {
    incorrectFormatResponse(
      res,
      errorCodes.INCORRECT_FORMAT,
      "INCORRECT_FORMAT",
      "Invalid value for votefor."
    );
    return;
  }

  try {
    const dispute = await Dispute.findOne({ _id: disputeId, status: "active" });

    if (dispute.votedBy.includes(userId)) {
      unAuthorizedResponse(res, errorCodes.UNAUTHORIZED);
      return;
    }

    let data;
    if (voteFor === "0") {
      data = {
        defendentsVote: dispute.defendentsVote + 1,
        votedBy: [...dispute.votedBy, userId],
      };
    } else if (voteFor == 1) {
      data = {
        initiatorsVote: dispute.initiatorsVote + 1,
        votedBy: [...dispute.votedBy, userId],
      };
    }

    if (dispute.defendentsVote + dispute.initiatorsVote + 1 >= 5) {
      data = { ...data, status: "completed" };
    }

    await Dispute.updateOne({ _id: disputeId }, data);
    const updatedDispute = await Dispute.findOne({
      _id: disputeId,
      status: "completed",
    });

    if (dispute.defendentsVote + dispute.initiatorsVote + 1 >= 5) {
      const initiatorWalletAddress = (
        await User.findById({ _id: updatedDispute.initiatorId }).select(
          "walletAddress"
        )
      ).walletAddress;
      const defendentWalletAddress = (
        await User.findById({ _id: updatedDispute.defenderId }).select(
          "walletAddress"
        )
      ).walletAddress;
      
      await disputeResult(
        initiatorWalletAddress,
        defendentWalletAddress,
        dispute.amount,
        dispute.initiatorsVote,
        dispute.defendentsVote
      );
    }
    

    onCreationResponse(res, {
      vote: "successful",
    });
  } catch (error) {
    console.log(error)
    serverErrorResponse(res, error, errorCodes.SERVER_ERROR);
  }
};
