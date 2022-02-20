const Request = require("../../models/Requests");
const {
  successfulGetResponse,
  serverErrorResponse,
  notFoundResponse,
} = require("../../helper/responses");

exports.requestDetails = async (req, res) => {
  const { _id } = req.body;

  try {
    const request = await Request.findById({ _id });
    if (!request) {
      notFoundResponse(
        res,
        "NOT_FOUND",
        "RequestNotFound",
        "Request is not found"
      );
      return;
    }
    successfulGetResponse(res, { request });
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
