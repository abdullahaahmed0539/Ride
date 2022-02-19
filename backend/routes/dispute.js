const router = require("express").Router();
const { createDispute } = require("../controllers/disputes/createDispute");
const { myDisputes } = require("../controllers/disputes/myDisputes");
const { disputesOnMe } = require("../controllers/disputes/disputesOnMe");
const { addMyClaim } = require("../controllers/disputes/addMyClaim");
const { disputeDetails } = require("../controllers/disputes/disputeDetails");

router.route("/create_dispute").post(createDispute); //add auth middleware
router.route("/my_disputes/:id").get(myDisputes); //add auth middleware
router.route("/disputes_on_me/:id").get(disputesOnMe); //add auth middleware
router.route("/add_my_claim").patch(addMyClaim); //add auth middleware
router.route("/:id").get(disputeDetails);

module.exports = router;
