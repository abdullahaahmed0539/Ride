const router = require("express").Router();
const { createBooking } = require("../controllers/bookings/createBooking");
const { acceptBooking } = require("../controllers/bookings/acceptBooking");
const {
  riderCancellation,
  driverCancellation,
} = require("../controllers/bookings/cancelRide");
const {
  myBookingHistory,
} = require("../controllers/bookings/myBookingHistory");
const {
  myScheduledBookings,
} = require("../controllers/bookings/myScheduledBookings");

router.route("/create_booking").post(createBooking);
router.route("/accept_booking").patch(acceptBooking);
router.route("/cancel_booking/rider").patch(riderCancellation);
router.route("/cancel_booking/driver").patch(driverCancellation);
router.route("/my_bookings_history").get(myBookingHistory);
router.route("/my_scheduled_bookings").get(myScheduledBookings);

module.exports = router;
