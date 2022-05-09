exports.calculateTravellingCost = (distance, milage) =>
  Math.round((distance / 1000 / milage) * process.env.FUEL_PRICE);

exports.calculateWaitTime = waitTime =>
  Math.round(waitTime * process.env.WAIT_TIME_COST_PER_MIN);

exports.calculateTotal = (distance, milage, waitTime) => {
  return (
    (this.calculateTravellingCost(distance, milage) +
      this.calculateWaitTime(waitTime) +
      parseInt(process.env.DISPUTE_COST)) *
    1.25
  );
};
