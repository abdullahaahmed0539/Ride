const Dispute = require("../../models/Disputes");
const {
  serverErrorResponse,
  notFoundResponse,
  onCreationResponse,
  unAuthorizedResponse,
  incorrectFormatResponse,
} = require("../../helper/responses");

exports.addVote = async (req, res) => {
  const { disputeId, userId, voteFor } = req.body;

  if (voteFor !== "1" && voteFor !== "0") {
    incorrectFormatResponse(
      res,
      "INCORRECT_FORMAT",
      "INCORRECT_FORMAT",
      "Invalid value for votefor."
    );
    return;
  }

  try {
    const dispute = await Dispute.findOne({ _id: disputeId, status: "active" });

    if (dispute.votedBy.includes(userId)) {
      unAuthorizedResponse(res, "UNAUTHORIZED_ACCESS");
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
    onCreationResponse(res, {
      vote: "successful",
    });
  } catch (error) {
    serverErrorResponse(res, error, "INTERNAL_SERVER_ERROR");
  }
};
