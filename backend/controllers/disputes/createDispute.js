const Dispute = require("../../models/Disputes");

const errorCodes = {
  MISSING_VAL: "MISSING_VALUE",
  SERVER_ERROR: "INTERNAL_SERVER_ERROR",
};

exports.createDispute = async (req, res) => {
  const { initiatorId, defenderId, subject, shortDescription, ridersClaim } =
    req.body;
  if (!initiatorId || !defenderId || !subject || !shortDescription) {
    res.status(406).json({
      request: "unsuccessful",
      error: {
        code: errorCodes.MISSING_VAL,
        name: "missingVal",
        message:
          "Either initiator id, rider's id, driver's id, or subject  is missing.",
        logs: "",
      },
      data: {},
    });
    return;
  }

  const newDispute = Dispute({
    initiatorId,
    defenderId,
    subject,
    shortDescription,
    ridersClaim,
    ridersVote: 0,
    driversVote: 0,
    publishedOn: new Date(),
    status: "pending",
  });

  try {
    await newDispute.save();
    res.status(201).json({
      request: "successful",
      error: {},
      data: {},
    });
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
