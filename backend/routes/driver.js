const router = require("express").Router();
const {
  driverDetailsForTrip,
} = require("../controllers/drivers/driverDetailsForTripSummary");
const { switchModes } = require("../controllers/drivers/switchModes");
const { addDriverRating } = require("../controllers/drivers/driverRating");
const { driverDetails } = require("../controllers/drivers/driverDetails");
const userAuth = require('../middlewares/userCheckAuth')
const driverAuth = require('../middlewares/driverCheckAuth')

router.route("/driver_details_for_trip").post(userAuth, driverDetailsForTrip);
router.route("/driver_details").post(userAuth, driverDetails);
router.route("/switch_mode").patch(driverAuth, switchModes);
router.route("/add_rating").patch(userAuth, addDriverRating);
module.exports = router;
