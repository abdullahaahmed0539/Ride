const router = require("express").Router();
const {
  driverDetailsForTrip,
} = require("../controllers/drivers/driverDetailsForTrip");
const { switchModes } = require("../controllers/drivers/switchModes");
const { addDriverRating } = require("../controllers/drivers/driverRating");
const userAuth = require('../middlewares/userCheckAuth')
const driverAuth = require('../middlewares/driverCheckAuth')

router.route("/driver_details_for_trip").get(userAuth, driverDetailsForTrip);
router.route("/switch_mode").patch(driverAuth, switchModes);
router.route("/add_rating").patch(driverAuth, addDriverRating);
module.exports = router;
