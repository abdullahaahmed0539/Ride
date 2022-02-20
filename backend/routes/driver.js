const router = require("express").Router();
const {
  driverDetailsForTrip,
} = require("../controllers/drivers/driverDetailsForTrip");
const { switchModes } = require("../controllers/drivers/switchModes");

router.route("/driver_details_for_trip").get(driverDetailsForTrip);
router.route("/switch_mode").patch(switchModes);
module.exports = router;
