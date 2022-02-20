const Request = require("../../models/Requests");
const {
  successfulGetResponse,
  serverErrorResponse,
} = require("../../helper/responses");

exports.requestDetails = async (req, res) => {
  const { _id } = req.body;

  try {
    const request = await Request.findById({ _id });
    successfulGetResponse(res, { request });
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
