const router = require("express").Router();
const { createDispute } = require("../controllers/disputes/createDispute");
const { myDisputes } = require("../controllers/disputes/myDisputes");
const { disputesOnMe } = require("../controllers/disputes/disputesOnMe");
const { addMyClaim } = require("../controllers/disputes/addMyClaim");
const { disputeDetails } = require("../controllers/disputes/disputeDetails");
const { addVote } = require('../controllers/voting/addVote')
const {disputesAvailableBreif} = require('../controllers/voting/disputesAvailableForVotingBrief')
const {
  disputesAvailableForVoting,
} = require("../controllers/voting/disputesAvailableForVoting");
const {
  myDisputesResults,
} = require("../controllers/disputes/myDisputesResults");
const {
  disputesOnMePending,
} = require("../controllers/disputes/disputeOnMePending");
const userAuth = require("../middlewares/userCheckAuth");

router.route("/create_dispute").post(userAuth, createDispute); 
router.route("/my_disputes/:id").post(userAuth, myDisputes); 
router.route("/my_disputes_results/:id").post(userAuth, myDisputesResults); 
router.route("/disputes_on_me_pending/:id").post(userAuth, disputesOnMePending);
router
  .route("/disputes_available_for_voting_brief/:id")
  .post(userAuth, disputesAvailableBreif); 
router
  .route("/disputes_available_for_voting/:id")
  .post(userAuth, disputesAvailableForVoting);
router.route("/disputes_on_me/:id").post(userAuth, disputesOnMe); 
router.route("/add_my_claim").patch(userAuth, addMyClaim); 
router.route("/add_vote").patch(userAuth, addVote); 
router.route("/:id").post(userAuth, disputeDetails);

module.exports = router;
