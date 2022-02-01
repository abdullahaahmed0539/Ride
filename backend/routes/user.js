const router = require("express").Router();
const { register } = require("../controllers/users/register");
const smsVerification = require("../middlewares/smsVerification");

router.route("/register").post(smsVerification, register);
// router.route("/login").post(login);

module.exports = router;
