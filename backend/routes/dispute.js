const router = require("express").Router();
const { createDispute } = require("../controllers/disputes/createDispute");
const { myDisputes } = require("../controllers/disputes/myDisputes");
// const { disputesOnMe } = require("../controllers/disputes/disputesOnMe");
// const { addMyClaim } = require("../controllers/disputes/addMyClaim");

router.route("/create_dispute").post(createDispute);
router.route("/my_disputes/:id").get(myDisputes);
// router.route("/disputes_on_me/:id").get(disputesOnMe);
// router.route("/add_my_claim").patch(addMyClaim);

module.exports = router;
