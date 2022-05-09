require('dotenv').config;
const { successfulGetResponse } = require("../../helper/responses");

exports.makePayments = async (req, res) => {
  const Stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
  const { amount } = req.body;
  try {
    const paymentIntent = await Stripe.paymentIntents.create({
      amount,
      currency: "usd",
    });
    successfulGetResponse(res, { paymentIntent: paymentIntent.client_secret });
  } catch (error) {
    console.log(error);
  }
};
