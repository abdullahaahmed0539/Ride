const router = require("express").Router();
const { getBalance } = require('../controllers/wallet/getBalance')
const { mintCoins } = require("../controllers/wallet/mintCoins");
const { getWorth } = require("../controllers/wallet/getTotalWorth");
const userAuth = require("../middlewares/userCheckAuth");

router.route("/get_worth").get(getWorth);
router.route("/get_balance").post(userAuth, getBalance);
router.route("/mint_coins").post(userAuth, mintCoins);

module.exports = router;
