const router = require("express").Router();
const {
  createOnBoardingRequest,
} = require("../controllers/requests/createOnBoardingRequest");
const { allRequests } = require("../controllers/requests/allRequests");
const { requestDetails } = require("../controllers/requests/requestDetails");
const {
  changeRequestStatus,
} = require("../controllers/requests/changeRequestStatus");
const userAuth = require('../middlewares/userCheckAuth')

router.route("/all_requests").get(allRequests); //admin auth needs to be added
router.route("/request_details").get(requestDetails); //admin auth needs to be added
router.route("/create_onboarding_request").post(userAuth, createOnBoardingRequest);
router.route("/change_request_status").patch(changeRequestStatus); //admin auth needs to be added

module.exports = router;
