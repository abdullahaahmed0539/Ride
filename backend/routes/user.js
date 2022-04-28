const router = require("express").Router();
const { register } = require("../controllers/users/register");
const { login } = require('../controllers/users/login');
const { userDetails } = require("../controllers/users/userDetail");
const { updateName } = require("../controllers/users/updateName");
const { updateEmail } = require("../controllers/users/updateEmail");
const { updatePhoneNumber } = require("../controllers/users/updatePhoneNumber");
const { addUserRating } = require("../controllers/users/addUserRating");
const { userExists } = require("../controllers/users/userExists");
const driverCheckAuth = require("../middlewares/driverCheckAuth");
const userCheckAuth = require("../middlewares/userCheckAuth");

router.route("/register").post(register);
router.route("/login").post(login)
router.route("/exists").post(userExists);
router.route("/details").post(userCheckAuth, userDetails); 
router.route("/update_name").patch(userCheckAuth, updateName); 
router.route("/update_phone_number").patch(userCheckAuth, updatePhoneNumber); 
router.route("/update_email").patch(userCheckAuth, updateEmail); 
router.route("/add_rating").patch(driverCheckAuth, addUserRating); 

module.exports = router;
