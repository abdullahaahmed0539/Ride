const router = require("express").Router();
const { startTrip } = require("../controllers/trips/startTrip");
const { endTrip } = require("../controllers/trips/endTrip");
const { tripDetails } = require("../controllers/trips/tripDetails");
const { setArrived } = require("../controllers/trips/setArrived");

router.route("/details").get(tripDetails);
router.route("/set_arrived").post(setArrived);
router.route("/start_trip").patch(startTrip);
router.route("/end_trip").patch(endTrip);

module.exports = router;
