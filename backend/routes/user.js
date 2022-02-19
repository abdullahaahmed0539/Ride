const router = require("express").Router();
const { register } = require("../controllers/users/register");
const { userDetails } = require("../controllers/users/userDetail");
const { updateName } = require("../controllers/users/updateName");
const { updateEmail } = require("../controllers/users/updateEmail");
const { updatePhoneNumber } = require("../controllers/users/updatePhoneNumber");
const { addUserRating } = require("../controllers/users/addUserRating");

router.route("/register").post(register);
router.route("/details").get(userDetails); //add auth middleware
router.route("/update_name").patch(updateName); //add auth middleware
router.route("/update_phone_number").patch(updatePhoneNumber); //add auth middleware
router.route("/update_email").patch(updateEmail); //add auth middleware
router.route("/add_user_rating/:phoneNumber").patch(addUserRating); //add auth middleware

module.exports = router;
