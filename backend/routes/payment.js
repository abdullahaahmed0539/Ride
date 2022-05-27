const router = require("express").Router();
const userAuth = require('../middlewares/userCheckAuth')
const { makePayments } = require("../controllers/payments/makePayments");


router.route("/make_payment").post( makePayments); 


module.exports = router;
