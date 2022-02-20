const router = require("express").Router();
const {
  createOnBoardingRequest,
} = require("../controllers/requests/createOnBoardingRequest");
const { allRequests } = require("../controllers/requests/allRequests");
const { requestDetails } = require("../controllers/requests/requestDetails");
const {
  changeRequestStatus,
} = require("../controllers/requests/changeRequestStatus");

router.route("/all_requests").get(allRequests);
router.route("/request_details").get(requestDetails);
router.route("/create_onboarding_request").post(createOnBoardingRequest);
router.route("/change_request_status").patch(changeRequestStatus);

module.exports = router;
