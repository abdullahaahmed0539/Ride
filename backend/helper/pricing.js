exports.calculateTravellingCost = (distance, milage) =>
  Math.round((distance / milage) * process.env.FUEL_PRICE);

exports.calculateWaitTime = waitTime =>
  Math.round(waitTime * process.env.WAIT_TIME_COST_PER_MIN);

exports.calculateTotal = (distance, milage, waitTime, disputeEnabled) => {
  let total = 0;
  if (disputeEnabled) {
    total =
      this.calculateTravellingCost(distance, milage) +
      this.calculateWaitTime(waitTime) +
      parseInt(process.env.DISPUTE_COST);
  } else {
    total =
      this.calculateTravellingCost(distance, milage) +
      this.calculateWaitTime(waitTime);
  }
  return total;
};
