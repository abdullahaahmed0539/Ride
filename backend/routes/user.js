const router = require("express").Router();
const { register } = require("../controllers/users/register");
const { userDetails } = require("../controllers/users/userDetail");
const { updateName } = require("../controllers/users/updateName");
const { updateEmail } = require("../controllers/users/updateEmail");
const { updatePhoneNumber } = require("../controllers/users/updatePhoneNumber");
// const smsVerification = require("../middlewares/smsVerification");

router.route("/register").post(register);
router.route("/:phoneNumber").get(userDetails);
router.route("/update_name/:phoneNumber").patch(updateName);
router.route("/update_phone_number/:phoneNumber").patch(updatePhoneNumber);
router.route("/update_email/:phoneNumber").patch(updateEmail);

module.exports = router;
