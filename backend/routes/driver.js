const router = require("express").Router();
const {
  driverDetailsForTrip,
} = require("../controllers/drivers/driverDetailsForTrip");

router.route("/driver_details_for_trip").get(driverDetailsForTrip);
module.exports = router;
