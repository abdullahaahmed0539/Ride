const router = require("express").Router();
const { startTrip } = require("../controllers/trips/startTrip");
const { endTrip } = require("../controllers/trips/endTrip");
const { tripDetails } = require("../controllers/trips/tripDetails");

router.route("/start_trip").post(startTrip);
router.route("/end_trip").post(endTrip);
router.route("/details").get(tripDetails);

module.exports = router;
