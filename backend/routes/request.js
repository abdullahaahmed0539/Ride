const router = require("express").Router();
const {createOnBoardingRequest,} = require("../controllers/requests/createOnBoardingRequest");
const userAuth = require('../middlewares/userCheckAuth')

router.route("/create_onboarding_request").post(userAuth, createOnBoardingRequest);

module.exports = router;
