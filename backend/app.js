const express = require("express");
const cors = require("cors");
const userRouter = require("./routes/user");
const driverRouter = require("./routes/driver");
const bookingRouter = require("./routes/booking");
const disputeRouter = require("./routes/dispute");
const tripRouter = require("./routes/trip");
const requestRouter = require("./routes/request");
const paymentRouter = require("./routes/payment");



const app = express();

app.use(express.json());
app.use(cors());

app.use("/users", userRouter);
app.use("/drivers", driverRouter);
app.use("/trips", tripRouter);
app.use("/bookings", bookingRouter);
app.use("/disputes", disputeRouter);
app.use("/requests", requestRouter);
app.use("/payments", paymentRouter);

module.exports = app;
