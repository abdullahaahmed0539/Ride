const router = require("express").Router();
const { createBooking } = require("../controllers/bookings/createBooking");
const {
  myBookingHistory,
} = require("../controllers/bookings/myBookingHistory");
const {
  myScheduledBookings,
} = require("../controllers/bookings/myScheduledBookings");
const { bookingDetails } = require("../controllers/bookings/bookingDetails");
const userAuth = require("../middlewares/userCheckAuth");
const driverAuth = require("../middlewares/driverCheckAuth");
const { driverBookingHistory } = require('../controllers/drivers/myBookingHistory')
const { driverScheduledBookings} = require("../controllers/drivers/myScheduledBookings");

router.route("/create_booking").post(driverAuth, createBooking);
router.route("/rider/my_bookings_history").post(userAuth, myBookingHistory);
router
  .route("/rider/my_scheduled_bookings")
  .post(userAuth, myScheduledBookings);
router
  .route("/driver/my_bookings_history")
  .post(driverAuth, driverBookingHistory);
router
  .route("/driver/my_scheduled_bookings")
  .post(driverAuth, driverScheduledBookings);
router.route("/details").post(userAuth, bookingDetails);

module.exports = router;
