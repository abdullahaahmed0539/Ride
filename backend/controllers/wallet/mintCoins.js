const {
  onMissingValResponse,
  serverErrorResponse,
  onCreationResponse,
} = require("../../helper/responses");
const { errorCodes } = require("../../helper/errorCodes");
const { mintRideCoins, getBalances } = require("../../blockchain/callingBlockchain");

exports.mintCoins = async (req, res) => {
  const { buyersWalletAddress, amount } = req.body;
  if (!buyersWalletAddress || !amount) {
    onMissingValResponse(
      res,
      errorCodes.MISSING_VAL,
      "Metamask wallet address of buyer or amount is  missing."
    );
    return;
  }

  try {
    await mintRideCoins(buyersWalletAddress, amount);
    onCreationResponse(res, {});
  } catch (err) {
    serverErrorResponse(res, err, errorCodes.SERVER_ERROR);
  }
};
