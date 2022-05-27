const {
  onMissingValResponse,
  successfulGetResponse,
  serverErrorResponse,
} = require("../../helper/responses");
const { errorCodes } = require("../../helper/errorCodes");
const { getContractWorth } = require("../../blockchain/callingBlockchain");

exports.getWorth = async (req, res) => {
  try {
    const worth = await getContractWorth();
    successfulGetResponse(res, { worth });
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
