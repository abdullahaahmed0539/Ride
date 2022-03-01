const router = require("express").Router();
const {
  driverDetailsForTrip,
} = require("../controllers/drivers/driverDetailsForTrip");
const { switchModes } = require("../controllers/drivers/switchModes");
const { addDriverRating } = require("../controllers/drivers/driverRating");

router.route("/driver_details_for_trip").get(driverDetailsForTrip);
router.route("/switch_mode").patch(switchModes);
router.route("/add_rating").patch(addDriverRating);
module.exports = router;
