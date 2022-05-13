/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Signer,
  utils,
  Contract,
  ContractFactory,
  Overrides,
  BigNumberish,
} from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type { ERC777Mock, ERC777MockInterface } from "../ERC777Mock";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "initialHolder",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "initialBalance",
        type: "uint256",
      },
      {
        internalType: "string",
        name: "name",
        type: "string",
      },
      {
        internalType: "string",
        name: "symbol",
        type: "string",
      },
      {
        internalType: "address[]",
        name: "defaultOperators",
        type: "address[]",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "Approval",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "operator",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "tokenHolder",
        type: "address",
      },
    ],
    name: "AuthorizedOperator",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [],
    name: "BeforeTokenTransfer",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "operator",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
      {
        indexed: false,
        internalType: "bytes",
        name: "operatorData",
        type: "bytes",
      },
    ],
    name: "Burned",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "operator",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
      {
        indexed: false,
        internalType: "bytes",
        name: "operatorData",
        type: "bytes",
      },
    ],
    name: "Minted",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "operator",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "tokenHolder",
        type: "address",
      },
    ],
    name: "RevokedOperator",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "operator",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
      {
        indexed: false,
        internalType: "bytes",
        name: "operatorData",
        type: "bytes",
      },
    ],
    name: "Sent",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "Transfer",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "holder",
        type: "address",
      },
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
    ],
    name: "allowance",
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
    inputs: [
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "approve",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "holder",
        type: "address",
      },
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "approveInternal",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "operator",
        type: "address",
      },
    ],
    name: "authorizeOperator",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "tokenHolder",
        type: "address",
      },
    ],
    name: "balanceOf",
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
    inputs: [
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
    ],
    name: "burn",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "decimals",
    outputs: [
      {
        internalType: "uint8",
        name: "",
        type: "uint8",
      },
    ],
    stateMutability: "pure",
    type: "function",
  },
  {
    inputs: [],
    name: "defaultOperators",
    outputs: [
      {
        internalType: "address[]",
        name: "",
        type: "address[]",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "granularity",
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
    inputs: [
      {
        internalType: "address",
        name: "operator",
        type: "address",
      },
      {
        internalType: "address",
        name: "tokenHolder",
        type: "address",
      },
    ],
    name: "isOperatorFor",
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
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "userData",
        type: "bytes",
      },
      {
        internalType: "bytes",
        name: "operatorData",
        type: "bytes",
      },
    ],
    name: "mintInternal",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "userData",
        type: "bytes",
      },
      {
        internalType: "bytes",
        name: "operatorData",
        type: "bytes",
      },
      {
        internalType: "bool",
        name: "requireReceptionAck",
        type: "bool",
      },
    ],
    name: "mintInternalExtended",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "name",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
      {
        internalType: "bytes",
        name: "operatorData",
        type: "bytes",
      },
    ],
    name: "operatorBurn",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "sender",
        type: "address",
      },
      {
        internalType: "address",
        name: "recipient",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
      {
        internalType: "bytes",
        name: "operatorData",
        type: "bytes",
      },
    ],
    name: "operatorSend",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "operator",
        type: "address",
      },
    ],
    name: "revokeOperator",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "recipient",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
    ],
    name: "send",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "symbol",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "totalSupply",
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
    inputs: [
      {
        internalType: "address",
        name: "recipient",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "transfer",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "holder",
        type: "address",
      },
      {
        internalType: "address",
        name: "recipient",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "transferFrom",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x60806040523480156200001157600080fd5b506040516200264638038062002646833981016040819052620000349162000803565b82828282600290805190602001906200004f929190620005fc565b50815162000065906003906020850190620005fc565b5080516200007b9060049060208401906200068b565b5060005b8151811015620000eb57600160056000848481518110620000a457620000a46200092c565b6020908102919091018101516001600160a01b03168252810191909152604001600020805460ff191691151591909117905580620000e28162000958565b9150506200007f565b506040516329965a1d60e01b815230600482018190527fac7fbab5f54a3ca8194167523c6753bfeb96a445279294b6125b68cce217705460248301526044820152731820a4b7618bde71dce8cdc73aab6c95905fad24906329965a1d90606401600060405180830381600087803b1580156200016657600080fd5b505af11580156200017b573d6000803e3d6000fd5b50506040516329965a1d60e01b815230600482018190527faea199e31a596269b42cdafd93407f14436db6e4cad65417994c2eb37381e05a60248301526044820152731820a4b7618bde71dce8cdc73aab6c95905fad2492506329965a1d9150606401600060405180830381600087803b158015620001f957600080fd5b505af11580156200020e573d6000803e3d6000fd5b5050505050505062000247858560405180602001604052806000815250604051806020016040528060008152506200025260201b60201c565b505050505062000ab8565b6200026284848484600162000268565b50505050565b6001600160a01b038516620002c45760405162461bcd60e51b815260206004820181905260248201527f4552433737373a206d696e7420746f20746865207a65726f206164647265737360448201526064015b60405180910390fd5b33620002d48160008888620003c9565b8460016000828254620002e8919062000976565b90915550506001600160a01b038616600090815260208190526040812080548792906200031790849062000976565b909155506200032f90508160008888888888620003f8565b856001600160a01b0316816001600160a01b03167f2fe5be0146f74c5bce36c0b80911af6c7d86ff27e89d5cfa61fc681327954e5d8787876040516200037893929190620009bf565b60405180910390a36040518581526001600160a01b038716906000907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9060200160405180910390a3505050505050565b6040517f52316ab8e8b0687ce803e403dfe429541bccd4f6c4683ec65d254d382f15a26590600090a150505050565b60405163555ddc6560e11b81526001600160a01b03861660048201527fb281fc8c12954d22544db45de3159a39272895b169a852b314f9cc762e44c53b6024820152600090731820a4b7618bde71dce8cdc73aab6c95905fad249063aabbb8ca9060440160206040518083038186803b1580156200047557600080fd5b505afa1580156200048a573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190620004b09190620009f8565b90506001600160a01b0381161562000532576040516223de2960e01b81526001600160a01b038216906223de2990620004f8908b908b908b908b908b908b9060040162000a1d565b600060405180830381600087803b1580156200051357600080fd5b505af115801562000528573d6000803e3d6000fd5b50505050620005e3565b8115620005e35762000558866001600160a01b0316620005ed60201b62000bb91760201c565b15620005e35760405162461bcd60e51b815260206004820152604d60248201527f4552433737373a20746f6b656e20726563697069656e7420636f6e747261637460448201527f20686173206e6f20696d706c656d656e74657220666f7220455243373737546f60648201526c1ad95b9cd49958da5c1a595b9d609a1b608482015260a401620002bb565b5050505050505050565b6001600160a01b03163b151590565b8280546200060a9062000a7b565b90600052602060002090601f0160209004810192826200062e576000855562000679565b82601f106200064957805160ff191683800117855562000679565b8280016001018555821562000679579182015b82811115620006795782518255916020019190600101906200065c565b5062000687929150620006e3565b5090565b82805482825590600052602060002090810192821562000679579160200282015b828111156200067957825182546001600160a01b0319166001600160a01b03909116178255602090920191600190910190620006ac565b5b80821115620006875760008155600101620006e4565b80516001600160a01b03811681146200071257600080fd5b919050565b634e487b7160e01b600052604160045260246000fd5b604051601f8201601f191681016001600160401b038111828210171562000758576200075862000717565b604052919050565b60005b838110156200077d57818101518382015260200162000763565b83811115620002625750506000910152565b600082601f830112620007a157600080fd5b81516001600160401b03811115620007bd57620007bd62000717565b620007d2601f8201601f19166020016200072d565b818152846020838601011115620007e857600080fd5b620007fb82602083016020870162000760565b949350505050565b600080600080600060a086880312156200081c57600080fd5b6200082786620006fa565b60208781015160408901519297509550906001600160401b03808211156200084e57600080fd5b6200085c8a838b016200078f565b955060608901519150808211156200087357600080fd5b620008818a838b016200078f565b945060808901519150808211156200089857600080fd5b818901915089601f830112620008ad57600080fd5b815181811115620008c257620008c262000717565b8060051b9150620008d58483016200072d565b818152918301840191848101908c841115620008f057600080fd5b938501935b8385101562000919576200090985620006fa565b82529385019390850190620008f5565b8096505050505050509295509295909350565b634e487b7160e01b600052603260045260246000fd5b634e487b7160e01b600052601160045260246000fd5b60006000198214156200096f576200096f62000942565b5060010190565b600082198211156200098c576200098c62000942565b500190565b60008151808452620009ab81602086016020860162000760565b601f01601f19169290920160200192915050565b838152606060208201526000620009da606083018562000991565b8281036040840152620009ee818562000991565b9695505050505050565b60006020828403121562000a0b57600080fd5b62000a1682620006fa565b9392505050565b6001600160a01b0387811682528681166020830152851660408201526060810184905260c06080820181905260009062000a5a9083018562000991565b82810360a084015262000a6e818562000991565b9998505050505050505050565b600181811c9082168062000a9057607f821691505b6020821081141562000ab257634e487b7160e01b600052602260045260246000fd5b50919050565b611b7e8062000ac86000396000f3fe608060405234801561001057600080fd5b50600436106101775760003560e01c8063959b8c3f116100d8578063cfbfab0b1161008c578063fad8b32a11610066578063fad8b32a14610311578063fc673c4f14610324578063fe9d93031461033757600080fd5b8063cfbfab0b146102b2578063d95b6371146102c5578063dd62ed3e146102d857600080fd5b80639bd9bbc6116100bd5780639bd9bbc614610279578063a9059cbb1461028c578063b1f0b5be1461029f57600080fd5b8063959b8c3f1461025e57806395d89b411461027157600080fd5b8063313ce5671161012f57806356189cb41161011457806356189cb41461020d57806362ad1b831461022257806370a082311461023557600080fd5b8063313ce567146101f7578063556f0dc71461020657600080fd5b8063095ea7b311610160578063095ea7b3146101af57806318160ddd146101d257806323b872dd146101e457600080fd5b806306e485381461017c57806306fdde031461019a575b600080fd5b61018461034a565b60405161019191906115ce565b60405180910390f35b6101a26103ac565b6040516101919190611668565b6101c26101bd366004611693565b610435565b6040519015158152602001610191565b6001545b604051908152602001610191565b6101c26101f23660046116bf565b61044d565b60405160128152602001610191565b60016101d6565b61022061021b3660046116bf565b61067b565b005b6102206102303660046117a3565b61068b565b6101d6610243366004611836565b6001600160a01b031660009081526020819052604090205490565b61022061026c366004611836565b61070c565b6101a261082a565b610220610287366004611853565b610839565b6101c261029a366004611693565b610857565b6102206102ad3660046118ac565b610946565b6102206102c036600461192c565b610958565b6101c26102d33660046119c6565b610965565b6101d66102e63660046119c6565b6001600160a01b03918216600090815260086020908152604080832093909416825291909152205490565b61022061031f366004611836565b610a07565b6102206103323660046118ac565b610b23565b6102206103453660046119ff565b610b9a565b606060048054806020026020016040519081016040528092919081815260200182805480156103a257602002820191906000526020600020905b81546001600160a01b03168152600190910190602001808311610384575b5050505050905090565b6060600280546103bb90611a46565b80601f01602080910402602001604051908101604052809291908181526020018280546103e790611a46565b80156103a25780601f10610409576101008083540402835291602001916103a2565b820191906000526020600020905b81548152906001019060200180831161041757509395945050505050565b600033610443818585610bc8565b5060019392505050565b60006001600160a01b0383166104b65760405162461bcd60e51b8152602060048201526024808201527f4552433737373a207472616e7366657220746f20746865207a65726f206164646044820152637265737360e01b60648201526084015b60405180910390fd5b6001600160a01b0384166105325760405162461bcd60e51b815260206004820152602660248201527f4552433737373a207472616e736665722066726f6d20746865207a65726f206160448201527f646472657373000000000000000000000000000000000000000000000000000060648201526084016104ad565b6000339050610563818686866040518060200160405280600081525060405180602001604052806000815250610d07565b6001600160a01b03808616600090815260086020908152604080832093851683529290522054600019811461061557838110156106085760405162461bcd60e51b815260206004820152602960248201527f4552433737373a207472616e7366657220616d6f756e7420657863656564732060448201527f616c6c6f77616e6365000000000000000000000000000000000000000000000060648201526084016104ad565b6106158683868403610bc8565b610641828787876040518060200160405280600081525060405180602001604052806000815250610e3e565b61066f8287878760405180602001604052806000815250604051806020016040528060008152506000610fc6565b50600195945050505050565b610686838383610bc8565b505050565b6106953386610965565b6106f65760405162461bcd60e51b815260206004820152602c60248201527f4552433737373a2063616c6c6572206973206e6f7420616e206f70657261746f60448201526b39103337b9103437b63232b960a11b60648201526084016104ad565b610705858585858560016111aa565b5050505050565b336001600160a01b03821614156107715760405162461bcd60e51b8152602060048201526024808201527f4552433737373a20617574686f72697a696e672073656c66206173206f70657260448201526330ba37b960e11b60648201526084016104ad565b6001600160a01b03811660009081526005602052604090205460ff16156107c2573360009081526007602090815260408083206001600160a01b03851684529091529020805460ff191690556107f1565b3360009081526006602090815260408083206001600160a01b03851684529091529020805460ff191660011790555b60405133906001600160a01b038316907ff4caeb2d6ca8932a215a353d0703c326ec2d81fc68170f320eb2ab49e9df61f990600090a350565b6060600380546103bb90611a46565b610686338484846040518060200160405280600081525060016111aa565b60006001600160a01b0383166108bb5760405162461bcd60e51b8152602060048201526024808201527f4552433737373a207472616e7366657220746f20746865207a65726f206164646044820152637265737360e01b60648201526084016104ad565b60003390506108ec818286866040518060200160405280600081525060405180602001604052806000815250610d07565b610918818286866040518060200160405280600081525060405180602001604052806000815250610e3e565b6104438182868660405180602001604052806000815250604051806020016040528060008152506000610fc6565b6109528484848461128d565b50505050565b6107058585858585611297565b6000816001600160a01b0316836001600160a01b031614806109d057506001600160a01b03831660009081526005602052604090205460ff1680156109d057506001600160a01b0380831660009081526007602090815260408083209387168352929052205460ff16155b80610a0057506001600160a01b0380831660009081526006602090815260408083209387168352929052205460ff165b9392505050565b6001600160a01b038116331415610a6a5760405162461bcd60e51b815260206004820152602160248201527f4552433737373a207265766f6b696e672073656c66206173206f70657261746f6044820152603960f91b60648201526084016104ad565b6001600160a01b03811660009081526005602052604090205460ff1615610abe573360009081526007602090815260408083206001600160a01b03851684529091529020805460ff19166001179055610aea565b3360009081526006602090815260408083206001600160a01b03851684529091529020805460ff191690555b60405133906001600160a01b038316907f50546e66e5f44d728365dc3908c63bc5cfeeab470722c1677e3073a6ac294aa190600090a350565b610b2d3385610965565b610b8e5760405162461bcd60e51b815260206004820152602c60248201527f4552433737373a2063616c6c6572206973206e6f7420616e206f70657261746f60448201526b39103337b9103437b63232b960a11b60648201526084016104ad565b610952848484846113e9565b610bb5338383604051806020016040528060008152506113e9565b5050565b6001600160a01b03163b151590565b6001600160a01b038316610c445760405162461bcd60e51b815260206004820152602560248201527f4552433737373a20617070726f76652066726f6d20746865207a65726f20616460448201527f647265737300000000000000000000000000000000000000000000000000000060648201526084016104ad565b6001600160a01b038216610ca65760405162461bcd60e51b815260206004820152602360248201527f4552433737373a20617070726f766520746f20746865207a65726f206164647260448201526265737360e81b60648201526084016104ad565b6001600160a01b0383811660008181526008602090815260408083209487168084529482529182902085905590518481527f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925910160405180910390a3505050565b60405163555ddc6560e11b81526001600160a01b03861660048201527f29ddb589b1fb5fc7cf394961c1adf5f8c6454761adf795e67fe149f658abe8956024820152600090731820a4b7618bde71dce8cdc73aab6c95905fad249063aabbb8ca9060440160206040518083038186803b158015610d8357600080fd5b505afa158015610d97573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610dbb9190611a81565b90506001600160a01b03811615610e3557604051633ad5cbc160e11b81526001600160a01b038216906375ab978290610e02908a908a908a908a908a908a90600401611a9e565b600060405180830381600087803b158015610e1c57600080fd5b505af1158015610e30573d6000803e3d6000fd5b505050505b50505050505050565b610e4a8686868661159f565b6001600160a01b03851660009081526020819052604090205483811015610ed95760405162461bcd60e51b815260206004820152602760248201527f4552433737373a207472616e7366657220616d6f756e7420657863656564732060448201527f62616c616e63650000000000000000000000000000000000000000000000000060648201526084016104ad565b6001600160a01b03808716600090815260208190526040808220878503905591871681529081208054869290610f10908490611b0d565b92505081905550846001600160a01b0316866001600160a01b0316886001600160a01b03167f06b541ddaa720db2b10a4d0cdac39b8d360425fc073085fac19bc82614677987878787604051610f6893929190611b25565b60405180910390a4846001600160a01b0316866001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef86604051610fb591815260200190565b60405180910390a350505050505050565b60405163555ddc6560e11b81526001600160a01b03861660048201527fb281fc8c12954d22544db45de3159a39272895b169a852b314f9cc762e44c53b6024820152600090731820a4b7618bde71dce8cdc73aab6c95905fad249063aabbb8ca9060440160206040518083038186803b15801561104257600080fd5b505afa158015611056573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061107a9190611a81565b90506001600160a01b038116156110f6576040516223de2960e01b81526001600160a01b038216906223de29906110bf908b908b908b908b908b908b90600401611a9e565b600060405180830381600087803b1580156110d957600080fd5b505af11580156110ed573d6000803e3d6000fd5b505050506111a0565b81156111a0576001600160a01b0386163b156111a05760405162461bcd60e51b815260206004820152604d60248201527f4552433737373a20746f6b656e20726563697069656e7420636f6e747261637460448201527f20686173206e6f20696d706c656d656e74657220666f7220455243373737546f60648201527f6b656e73526563697069656e7400000000000000000000000000000000000000608482015260a4016104ad565b5050505050505050565b6001600160a01b03861661120b5760405162461bcd60e51b815260206004820152602260248201527f4552433737373a2073656e642066726f6d20746865207a65726f206164647265604482015261737360f01b60648201526084016104ad565b6001600160a01b0385166112615760405162461bcd60e51b815260206004820181905260248201527f4552433737373a2073656e6420746f20746865207a65726f206164647265737360448201526064016104ad565b33611270818888888888610d07565b61127e818888888888610e3e565b610e3581888888888888610fc6565b6109528484848460015b6001600160a01b0385166112ed5760405162461bcd60e51b815260206004820181905260248201527f4552433737373a206d696e7420746f20746865207a65726f206164647265737360448201526064016104ad565b336112fb816000888861159f565b846001600082825461130d9190611b0d565b90915550506001600160a01b0386166000908152602081905260408120805487929061133a908490611b0d565b9091555061135090508160008888888888610fc6565b856001600160a01b0316816001600160a01b03167f2fe5be0146f74c5bce36c0b80911af6c7d86ff27e89d5cfa61fc681327954e5d87878760405161139793929190611b25565b60405180910390a36040518581526001600160a01b038716906000907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef906020015b60405180910390a3505050505050565b6001600160a01b03841661144a5760405162461bcd60e51b815260206004820152602260248201527f4552433737373a206275726e2066726f6d20746865207a65726f206164647265604482015261737360f01b60648201526084016104ad565b3361145a81866000878787610d07565b611467818660008761159f565b6001600160a01b038516600090815260208190526040902054848110156114dc5760405162461bcd60e51b815260206004820152602360248201527f4552433737373a206275726e20616d6f756e7420657863656564732062616c616044820152626e636560e81b60648201526084016104ad565b6001600160a01b038616600090815260208190526040812086830390556001805487929061150b908490611b5a565b92505081905550856001600160a01b0316826001600160a01b03167fa78a9be3a7b862d26933ad85fb11d80ef66b8f972d7cbba06621d583943a409887878760405161155993929190611b25565b60405180910390a36040518581526000906001600160a01b038816907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef906020016113d9565b6040517f52316ab8e8b0687ce803e403dfe429541bccd4f6c4683ec65d254d382f15a26590600090a150505050565b6020808252825182820181905260009190848201906040850190845b8181101561160f5783516001600160a01b0316835292840192918401916001016115ea565b50909695505050505050565b6000815180845260005b8181101561164157602081850181015186830182015201611625565b81811115611653576000602083870101525b50601f01601f19169290920160200192915050565b602081526000610a00602083018461161b565b6001600160a01b038116811461169057600080fd5b50565b600080604083850312156116a657600080fd5b82356116b18161167b565b946020939093013593505050565b6000806000606084860312156116d457600080fd5b83356116df8161167b565b925060208401356116ef8161167b565b929592945050506040919091013590565b634e487b7160e01b600052604160045260246000fd5b600082601f83011261172757600080fd5b813567ffffffffffffffff8082111561174257611742611700565b604051601f8301601f19908116603f0116810190828211818310171561176a5761176a611700565b8160405283815286602085880101111561178357600080fd5b836020870160208301376000602085830101528094505050505092915050565b600080600080600060a086880312156117bb57600080fd5b85356117c68161167b565b945060208601356117d68161167b565b935060408601359250606086013567ffffffffffffffff808211156117fa57600080fd5b61180689838a01611716565b9350608088013591508082111561181c57600080fd5b5061182988828901611716565b9150509295509295909350565b60006020828403121561184857600080fd5b8135610a008161167b565b60008060006060848603121561186857600080fd5b83356118738161167b565b925060208401359150604084013567ffffffffffffffff81111561189657600080fd5b6118a286828701611716565b9150509250925092565b600080600080608085870312156118c257600080fd5b84356118cd8161167b565b935060208501359250604085013567ffffffffffffffff808211156118f157600080fd5b6118fd88838901611716565b9350606087013591508082111561191357600080fd5b5061192087828801611716565b91505092959194509250565b600080600080600060a0868803121561194457600080fd5b853561194f8161167b565b945060208601359350604086013567ffffffffffffffff8082111561197357600080fd5b61197f89838a01611716565b9450606088013591508082111561199557600080fd5b506119a288828901611716565b925050608086013580151581146119b857600080fd5b809150509295509295909350565b600080604083850312156119d957600080fd5b82356119e48161167b565b915060208301356119f48161167b565b809150509250929050565b60008060408385031215611a1257600080fd5b82359150602083013567ffffffffffffffff811115611a3057600080fd5b611a3c85828601611716565b9150509250929050565b600181811c90821680611a5a57607f821691505b60208210811415611a7b57634e487b7160e01b600052602260045260246000fd5b50919050565b600060208284031215611a9357600080fd5b8151610a008161167b565b60006001600160a01b038089168352808816602084015280871660408401525084606083015260c06080830152611ad860c083018561161b565b82810360a0840152611aea818561161b565b9998505050505050505050565b634e487b7160e01b600052601160045260246000fd5b60008219821115611b2057611b20611af7565b500190565b838152606060208201526000611b3e606083018561161b565b8281036040840152611b50818561161b565b9695505050505050565b600082821015611b6c57611b6c611af7565b50039056fea164736f6c6343000809000a";

type ERC777MockConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ERC777MockConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ERC777Mock__factory extends ContractFactory {
  constructor(...args: ERC777MockConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  deploy(
    initialHolder: string,
    initialBalance: BigNumberish,
    name: string,
    symbol: string,
    defaultOperators: string[],
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ERC777Mock> {
    return super.deploy(
      initialHolder,
      initialBalance,
      name,
      symbol,
      defaultOperators,
      overrides || {}
    ) as Promise<ERC777Mock>;
  }
  getDeployTransaction(
    initialHolder: string,
    initialBalance: BigNumberish,
    name: string,
    symbol: string,
    defaultOperators: string[],
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(
      initialHolder,
      initialBalance,
      name,
      symbol,
      defaultOperators,
      overrides || {}
    );
  }
  attach(address: string): ERC777Mock {
    return super.attach(address) as ERC777Mock;
  }
  connect(signer: Signer): ERC777Mock__factory {
    return super.connect(signer) as ERC777Mock__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ERC777MockInterface {
    return new utils.Interface(_abi) as ERC777MockInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ERC777Mock {
    return new Contract(address, _abi, signerOrProvider) as ERC777Mock;
  }
}
