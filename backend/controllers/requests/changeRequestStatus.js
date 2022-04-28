const Request = require("../../models/Requests");
const Driver = require("../../models/Drivers");
const User = require("../../models/Users");
const { initializeApp } = require("firebase/app");
const { getDatabase, ref, set } = require("firebase/database");

const {
  onMissingValResponse,
  serverErrorResponse,
  notFoundResponse,
  onCreationResponse,
} = require("../../helper/responses");

FIREBASE_CONFIGURATION = {
  apiKey: process.env.FIREBASE_CONFIGURATION_API_KEY,
  authDomain: "ride-347116.firebaseapp.com",
  databaseURL:
    "https://ride-347116-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "ride-347116",
  storageBucket: "ride-347116.appspot.com",
  messagingSenderId: "538809823991",
  appId: "1:538809823991:web:1066a170a8f7bf323d99f2",
  measurementId: "G-3VNJLKDWYM",
};

const firebaseDb = getDatabase(initializeApp(FIREBASE_CONFIGURATION));

// set(ref(firebaseDb, "dummy/"), {
//   'h': 'i'
// });

exports.changeRequestStatus = async (req, res) => {
  const { _id, decision } = req.body;
  if (!_id || !decision) {
    onMissingValResponse(
      res,
      "MISSING_VAL",
      "Request id or decision is missing."
    );
    return;
  }

  try {
    const updatedStatus = await Request.updateOne(
      { _id, status: "pending" },
      { decisionDate: Date.now(), status: decision }
    );
    if (updatedStatus.modifiedCount > 0) {
      if (decision === "accepted") {
        const driverDetails = await Request.findById({ _id }).select(
          "-dateApproved -status"
        );
        const newDriver = Driver({
          userId: driverDetails.userId,
          licenseURL: driverDetails.licenseURL,
          cnic: driverDetails.cnic,
          milage: driverDetails.milage,
          carModel: driverDetails.carModel,
          color: driverDetails.color,
          registrationNumber: driverDetails.registrationNumber,
          rating: [],
          isActive: false,
          isBusy: false,
        });
        const driverDetailsFromDb = await newDriver.save();
        
        if (driverDetailsFromDb !== null){
          
          await set(ref(firebaseDb, "drivers/" + driverDetailsFromDb._id), {
            'rideRequestStatus': 'idle',
            });
        }  
          
        
        await User.updateOne({ _id: driverDetails.userId }, { isDriver: true });
      }
      onCreationResponse(res, {});
    } else {
      notFoundResponse(
        res,
        "NOT_FOUND",
        "RequestNotFOund",
        "The following request does not exist."
      );
    }
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
