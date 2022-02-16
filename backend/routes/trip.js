const router = require("express").Router();
const { startTrip } = require("../controllers/trips/startTrip");
const { endTrip } = require("../controllers/trips/endTrip");

router.route("/start_trip").post(startTrip);
router.route("/end_trip").post(endTrip);

module.exports = router;
