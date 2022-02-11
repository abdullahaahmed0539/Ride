const router = require("express").Router();
const { createBooking } = require("../controllers/bookings/createBooking");
const { acceptBooking } = require("../controllers/bookings/acceptBooking");

router.route("/create_booking").post(createBooking);
router.route("/accept_booking").patch(acceptBooking);

module.exports = router;
