const Requests = require("../../models/Requests");
const {
  successfulGetResponse,
  serverErrorResponse,
} = require("../../helper/responses");

exports.allRequests = async (req, res) => {
  try {
    const requests = await Requests.find({ status: "pending" });
    successfulGetResponse(res, { requests });
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
