const {
  onMissingValResponse,
  successfulGetResponse,
  serverErrorResponse,
} = require("../../helper/responses");
const { errorCodes } = require("../../helper/errorCodes");
const { getBalances } = require("../../blockchain/callingBlockchain");

exports.getBalance = async (req, res) => {
  const { walletAddress } = req.body;
  if (!walletAddress) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Metamask wallet address missing."
    );
    return;
  }

  try {
    const balance = await getBalances(walletAddress);
    successfulGetResponse(res, {balance});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
