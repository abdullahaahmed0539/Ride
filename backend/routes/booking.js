const router = require("express").Router();
const { createBooking } = require("../controllers/bookings/createBooking");
const { acceptBooking } = require("../controllers/bookings/acceptBooking");
const {
  riderCancellation,
  driverCancellation,
} = require("../controllers/bookings/cancelRide");

router.route("/create_booking").post(createBooking);
router.route("/accept_booking").patch(acceptBooking);
router.route("/cancel_booking/rider").patch(riderCancellation);
router.route("/cancel_booking/driver").patch(driverCancellation);

module.exports = router;
