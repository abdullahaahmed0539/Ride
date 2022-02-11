const router = require("express").Router();
const { createBooking } = require("../controllers/bookings/createBooking");

router.route("/create_booking").post(createBooking);

module.exports = router;
