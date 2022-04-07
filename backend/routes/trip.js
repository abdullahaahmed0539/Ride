const router = require("express").Router();
const { startTrip } = require("../controllers/trips/startTrip");
const { endTrip } = require("../controllers/trips/endTrip");
const { tripDetails } = require("../controllers/trips/tripDetails");
const { setArrived } = require("../controllers/trips/setArrived");
const userAuth = require('../middlewares/userCheckAuth')
const driverAuth = require('../middlewares/driverCheckAuth')

router.route("/details").post(userAuth, tripDetails);
router.route("/set_arrived").post(driverAuth, setArrived);
router.route("/start_trip").patch(driverAuth, startTrip);
router.route("/end_trip").patch(driverAuth, endTrip);

module.exports = router;
