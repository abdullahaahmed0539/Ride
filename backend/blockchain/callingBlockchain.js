const { Contract, providers, BigNumber, Wallet } = require("ethers");
require("dotenv").config();

const privateKey = process.env.PRIVATE_KEY;

const url = process.env.RPC_URL;

const provider = new providers.JsonRpcProvider(url);

const wallet = new Wallet(privateKey, provider);

var contract = new Contract(
  "0x742d3f8e94Ba36935Ef88255d290a3C19F9a00eB",
  [
    {
      inputs: [],
      stateMutability: "nonpayable",
      type: "constructor",
    },
    {
      anonymous: false,
      inputs: [
        {
          indexed: false,
          internalType: "string",
          name: "bookingID",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "riderID",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "driverID",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "bookingTime",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "pickup",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "dropoff",
          type: "string",
        },
      ],
      name: "Booking",
      type: "event",
    },
    {
      inputs: [
        {
          internalType: "string",
          name: "bookingID",
          type: "string",
        },
        {
          internalType: "string",
          name: "riderID",
          type: "string",
        },
        {
          internalType: "string",
          name: "driverID",
          type: "string",
        },
        {
          internalType: "string",
          name: "bookingTime",
          type: "string",
        },
        {
          internalType: "string",
          name: "pickup",
          type: "string",
        },
        {
          internalType: "string",
          name: "dropoff",
          type: "string",
        },
      ],
      name: "bookingLog",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_rider",
          type: "address",
        },
        {
          internalType: "uint256",
          name: "_amount",
          type: "uint256",
        },
        {
          internalType: "address",
          name: "_driver",
          type: "address",
        },
      ],
      name: "collectDisputeAmount",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_rider",
          type: "address",
        },
        {
          internalType: "address",
          name: "_driver",
          type: "address",
        },
        {
          internalType: "uint256",
          name: "_amount",
          type: "uint256",
        },
        {
          internalType: "uint256",
          name: "_riderVote",
          type: "uint256",
        },
        {
          internalType: "uint256",
          name: "_driverVote",
          type: "uint256",
        },
      ],
      name: "disputeResult",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_rider",
          type: "address",
        },
        {
          internalType: "address",
          name: "_driver",
          type: "address",
        },
        {
          internalType: "uint256",
          name: "_fareAmount",
          type: "uint256",
        },
      ],
      name: "endRide",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_driver",
          type: "address",
        },
        {
          internalType: "uint256",
          name: "_amount",
          type: "uint256",
        },
      ],
      name: "giveCollatToDriver",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_buyer",
          type: "address",
        },
        {
          internalType: "uint256",
          name: "_amount",
          type: "uint256",
        },
      ],
      name: "mintRideCoins",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "uint256",
          name: "_amount",
          type: "uint256",
        },
      ],
      name: "setAmountForCollat",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      anonymous: false,
      inputs: [
        {
          indexed: false,
          internalType: "string",
          name: "bookingID",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "distance",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "startTime",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "endTime",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "total",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "fuelCost",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "waitTimeCostPerMin",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "disputeCost",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "waitTimeCost",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "milesCost",
          type: "string",
        },
      ],
      name: "Trip",
      type: "event",
    },
    {
      inputs: [
        {
          internalType: "string",
          name: "bookingID",
          type: "string",
        },
        {
          internalType: "string",
          name: "distance",
          type: "string",
        },
        {
          internalType: "string",
          name: "startTime",
          type: "string",
        },
        {
          internalType: "string",
          name: "endTime",
          type: "string",
        },
        {
          internalType: "string",
          name: "total",
          type: "string",
        },
        {
          internalType: "string",
          name: "fuelCost",
          type: "string",
        },
        {
          internalType: "string",
          name: "waitTimeCostPerMin",
          type: "string",
        },
        {
          internalType: "string",
          name: "disputeCost",
          type: "string",
        },
        {
          internalType: "string",
          name: "waitTimeCost",
          type: "string",
        },
        {
          internalType: "string",
          name: "milesCost",
          type: "string",
        },
      ],
      name: "tripLog",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      stateMutability: "payable",
      type: "fallback",
    },
    {
      stateMutability: "payable",
      type: "receive",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_rider",
          type: "address",
        },
        {
          internalType: "uint256",
          name: "_estimateFare",
          type: "uint256",
        },
      ],
      name: "checkifSufficientCoins",
      outputs: [
        {
          internalType: "bool",
          name: "",
          type: "bool",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_driver",
          type: "address",
        },
      ],
      name: "checkifSufficientCollat",
      outputs: [
        {
          internalType: "bool",
          name: "",
          type: "bool",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
    {
      inputs: [],
      name: "coins",
      outputs: [
        {
          internalType: "contract rideToken",
          name: "",
          type: "address",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_user",
          type: "address",
        },
      ],
      name: "getBalances",
      outputs: [
        {
          internalType: "uint256",
          name: "",
          type: "uint256",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
    {
      inputs: [],
      name: "getContractWorth",
      outputs: [
        {
          internalType: "uint256",
          name: "",
          type: "uint256",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
  ],
  wallet
);

exports.endRide = async (riderWalletAddress, DriverWalletAddress, amount) => {
  await contract.endRide(riderWalletAddress, DriverWalletAddress, amount);
};

exports.giveCollatToDriver = async (_address, _amount) => {
  await contract.giveCollatToDriver(_address, _amount);
};

exports.mintRideCoins = async (_buyer, _amount) => {
  await contract.mintRideCoins(_buyer, _amount);
};
exports.getBalances = async _address => {
  const balance = await contract.getBalances(_address);
  return balance.toNumber();
};
exports.collectDisputeAmount = async (_rider, _amount, _driver) => {
  await contract.collectDisputeAmount(_rider, _amount, _driver);
};
exports.disputeResult = async (
  _rider,
  _driver,
  _amount,
  _riderVote,
  _driverVote
) => {
  await contract.disputeResult(
    _rider,
    _driver,
    _amount,
    _riderVote,
    _driverVote
  );
};
exports.getContractWorth = async () => {
  const worth = await contract.getContractWorth();
  return worth.toNumber();
};
exports.bookingLog = async (
  _bookingID,
  _riderID,
  _driverID,
  _bookingTime,
  _pickup,
  _dropoff
) => {
  await contract.bookingLog(
    _bookingID,
    _riderID,
    _driverID,
    _bookingTime,
    _pickup,
    _dropoff
  );
};
exports.tripLog = async (
  _bookingID,
  _distance,
  _startTime,
  _endTime,
  _total,
  _fuelCost,
  _waitTimeCostPerMin,
  _disputeCost,
  _waitTimeCost,
  _milesCost
) => {
  await contract.tripLog(
    _bookingID,
    _distance,
    _startTime,
    _endTime,
    _total,
    _fuelCost,
    _waitTimeCostPerMin,
    _disputeCost,
    _waitTimeCost,
    _milesCost
  );
};
