const router = require("express").Router();
const { createDispute } = require("../controllers/disputes/createDispute");
const { myDisputes } = require("../controllers/disputes/myDisputes");
const { disputesOnMe } = require("../controllers/disputes/disputesOnMe");
const { addMyClaim } = require("../controllers/disputes/addMyClaim");
const { disputeDetails } = require("../controllers/disputes/disputeDetails");
const userAuth = require("../middlewares/userCheckAuth");

router.route("/create_dispute").post(userAuth, createDispute); //add auth middleware
router.route("/my_disputes/:id").get(userAuth, myDisputes); //add auth middleware
router.route("/disputes_on_me/:id").get(userAuth, disputesOnMe); //add auth middleware
router.route("/add_my_claim").patch(userAuth, addMyClaim); //add auth middleware
router.route("/:id").get(userAuth, disputeDetails);

module.exports = router;
