const router = require("express").Router();
const { register } = require("../controllers/users/register");
const { login } = require('../controllers/users/login');
const { userDetails } = require("../controllers/users/userDetail");
const { updateName } = require("../controllers/users/updateName");
const { updateEmail } = require("../controllers/users/updateEmail");
const { updatePhoneNumber } = require("../controllers/users/updatePhoneNumber");
const { addUserRating } = require("../controllers/users/addUserRating");
const { userExists } = require("../controllers/users/userExists");
const userCheckAuth = require('../middlewares/userCheckAuth')

router.route("/register").post(register);
router.route("/login").post(login)
router.route("/exists").post(userExists);
router.route("/details").post(userCheckAuth, userDetails); //add auth middleware
router.route("/update_name").patch(userCheckAuth, updateName); //add auth middleware
router.route("/update_phone_number").patch(userCheckAuth, updatePhoneNumber); //add auth middleware
router.route("/update_email").patch(userCheckAuth, updateEmail); //add auth middleware
router.route("/add_user_rating/:phoneNumber").patch(userCheckAuth, addUserRating); //add auth middleware

module.exports = router;
