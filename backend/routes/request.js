const router = require("express").Router();
const {
  createOnBoardingRequest,
} = require("../controllers/requests/createOnBoardingRequest");

router.route("/create_onboarding_request").post(createOnBoardingRequest);

module.exports = router;
