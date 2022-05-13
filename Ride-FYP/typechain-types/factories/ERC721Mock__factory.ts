/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type { ERC721Mock, ERC721MockInterface } from "../ERC721Mock";

const _abi = [
  {
    inputs: [
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
        name: "approved",
        type: "address",
      },
      {
        indexed: true,
        internalType: "uint256",
        name: "tokenId",
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
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "operator",
        type: "address",
      },
      {
        indexed: false,
        internalType: "bool",
        name: "approved",
        type: "bool",
      },
    ],
    name: "ApprovalForAll",
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
        indexed: true,
        internalType: "uint256",
        name: "tokenId",
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
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "approve",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "owner",
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
    inputs: [],
    name: "baseURI",
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
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "burn",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "exists",
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
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "getApproved",
    outputs: [
      {
        internalType: "address",
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
        name: "owner",
        type: "address",
      },
      {
        internalType: "address",
        name: "operator",
        type: "address",
      },
    ],
    name: "isApprovedForAll",
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
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "mint",
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
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "ownerOf",
    outputs: [
      {
        internalType: "address",
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
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "_data",
        type: "bytes",
      },
    ],
    name: "safeMint",
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
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "safeMint",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "safeTransferFrom",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "_data",
        type: "bytes",
      },
    ],
    name: "safeTransferFrom",
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
      {
        internalType: "bool",
        name: "approved",
        type: "bool",
      },
    ],
    name: "setApprovalForAll",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes4",
        name: "interfaceId",
        type: "bytes4",
      },
    ],
    name: "supportsInterface",
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
    inputs: [
      {
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "tokenURI",
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
        name: "from",
        type: "address",
      },
      {
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "tokenId",
        type: "uint256",
      },
    ],
    name: "transferFrom",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x60806040523480156200001157600080fd5b50604051620019fe380380620019fe8339810160408190526200003491620001e1565b8151829082906200004d9060009060208501906200006e565b508051620000639060019060208401906200006e565b505050505062000288565b8280546200007c906200024b565b90600052602060002090601f016020900481019282620000a05760008555620000eb565b82601f10620000bb57805160ff1916838001178555620000eb565b82800160010185558215620000eb579182015b82811115620000eb578251825591602001919060010190620000ce565b50620000f9929150620000fd565b5090565b5b80821115620000f95760008155600101620000fe565b634e487b7160e01b600052604160045260246000fd5b600082601f8301126200013c57600080fd5b81516001600160401b038082111562000159576200015962000114565b604051601f8301601f19908116603f0116810190828211818310171562000184576200018462000114565b81604052838152602092508683858801011115620001a157600080fd5b600091505b83821015620001c55785820183015181830184015290820190620001a6565b83821115620001d75760008385830101525b9695505050505050565b60008060408385031215620001f557600080fd5b82516001600160401b03808211156200020d57600080fd5b6200021b868387016200012a565b935060208501519150808211156200023257600080fd5b5062000241858286016200012a565b9150509250929050565b600181811c908216806200026057607f821691505b602082108114156200028257634e487b7160e01b600052602260045260246000fd5b50919050565b61176680620002986000396000f3fe608060405234801561001057600080fd5b50600436106101515760003560e01c80636352211e116100cd578063a144819411610081578063b88d4fde11610066578063b88d4fde146102af578063c87b56dd146102c2578063e985e9c5146102d557600080fd5b8063a144819414610289578063a22cb4651461029c57600080fd5b806370a08231116100b257806370a082311461024d5780638832e6e31461026e57806395d89b411461028157600080fd5b80636352211e146102325780636c0360eb1461024557600080fd5b806323b872dd1161012457806342842e0e1161010957806342842e0e146101f957806342966c681461020c5780634f558e791461021f57600080fd5b806323b872dd146101d357806340c10f19146101e657600080fd5b806301ffc9a71461015657806306fdde031461017e578063081812fc14610193578063095ea7b3146101be575b600080fd5b6101696101643660046112d3565b610311565b60405190151581526020015b60405180910390f35b610186610363565b6040516101759190611348565b6101a66101a136600461135b565b6103f5565b6040516001600160a01b039091168152602001610175565b6101d16101cc366004611390565b61048f565b005b6101d16101e13660046113ba565b6105a5565b6101d16101f4366004611390565b61062c565b6101d16102073660046113ba565b61063a565b6101d161021a36600461135b565b610655565b61016961022d36600461135b565b610661565b6101a661024036600461135b565b610680565b61018661070b565b61026061025b3660046113f6565b610727565b604051908152602001610175565b6101d161027c3660046114b4565b6107c1565b6101866107cc565b6101d1610297366004611390565b6107db565b6101d16102aa36600461150b565b6107e5565b6101d16102bd366004611547565b6107f0565b6101866102d036600461135b565b61087e565b6101696102e33660046115af565b6001600160a01b03918216600090815260056020908152604080832093909416825291909152205460ff1690565b60006001600160e01b031982166380ac58cd60e01b148061034257506001600160e01b03198216635b5e139f60e01b145b8061035d57506301ffc9a760e01b6001600160e01b03198316145b92915050565b606060008054610372906115e2565b80601f016020809104026020016040519081016040528092919081815260200182805461039e906115e2565b80156103eb5780601f106103c0576101008083540402835291602001916103eb565b820191906000526020600020905b8154815290600101906020018083116103ce57829003601f168201915b5050505050905090565b6000818152600260205260408120546001600160a01b03166104735760405162461bcd60e51b815260206004820152602c60248201527f4552433732313a20617070726f76656420717565727920666f72206e6f6e657860448201526b34b9ba32b73a103a37b5b2b760a11b60648201526084015b60405180910390fd5b506000908152600460205260409020546001600160a01b031690565b600061049a82610680565b9050806001600160a01b0316836001600160a01b031614156105085760405162461bcd60e51b815260206004820152602160248201527f4552433732313a20617070726f76616c20746f2063757272656e74206f776e656044820152603960f91b606482015260840161046a565b336001600160a01b0382161480610524575061052481336102e3565b6105965760405162461bcd60e51b815260206004820152603860248201527f4552433732313a20617070726f76652063616c6c6572206973206e6f74206f7760448201527f6e6572206e6f7220617070726f76656420666f7220616c6c0000000000000000606482015260840161046a565b6105a08383610974565b505050565b6105af33826109e2565b6106215760405162461bcd60e51b815260206004820152603160248201527f4552433732313a207472616e736665722063616c6c6572206973206e6f74206f60448201527f776e6572206e6f7220617070726f766564000000000000000000000000000000606482015260840161046a565b6105a0838383610ad9565b6106368282610c8d565b5050565b6105a0838383604051806020016040528060008152506107f0565b61065e81610dcf565b50565b6000818152600260205260408120546001600160a01b0316151561035d565b6000818152600260205260408120546001600160a01b03168061035d5760405162461bcd60e51b815260206004820152602960248201527f4552433732313a206f776e657220717565727920666f72206e6f6e657869737460448201527f656e7420746f6b656e0000000000000000000000000000000000000000000000606482015260840161046a565b606061072260408051602081019091526000815290565b905090565b60006001600160a01b0382166107a55760405162461bcd60e51b815260206004820152602a60248201527f4552433732313a2062616c616e636520717565727920666f7220746865207a6560448201527f726f206164647265737300000000000000000000000000000000000000000000606482015260840161046a565b506001600160a01b031660009081526003602052604090205490565b6105a0838383610e6a565b606060018054610372906115e2565b6106368282610ee8565b610636338383610f02565b6107fa33836109e2565b61086c5760405162461bcd60e51b815260206004820152603160248201527f4552433732313a207472616e736665722063616c6c6572206973206e6f74206f60448201527f776e6572206e6f7220617070726f766564000000000000000000000000000000606482015260840161046a565b61087884848484610fd1565b50505050565b6000818152600260205260409020546060906001600160a01b031661090b5760405162461bcd60e51b815260206004820152602f60248201527f4552433732314d657461646174613a2055524920717565727920666f72206e6f60448201527f6e6578697374656e7420746f6b656e0000000000000000000000000000000000606482015260840161046a565b600061092260408051602081019091526000815290565b90506000815111610942576040518060200160405280600081525061096d565b8061094c8461104f565b60405160200161095d92919061161d565b6040516020818303038152906040525b9392505050565b600081815260046020526040902080546001600160a01b0319166001600160a01b03841690811790915581906109a982610680565b6001600160a01b03167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b92560405160405180910390a45050565b6000818152600260205260408120546001600160a01b0316610a5b5760405162461bcd60e51b815260206004820152602c60248201527f4552433732313a206f70657261746f7220717565727920666f72206e6f6e657860448201526b34b9ba32b73a103a37b5b2b760a11b606482015260840161046a565b6000610a6683610680565b9050806001600160a01b0316846001600160a01b03161480610aa15750836001600160a01b0316610a96846103f5565b6001600160a01b0316145b80610ad157506001600160a01b0380821660009081526005602090815260408083209388168352929052205460ff165b949350505050565b826001600160a01b0316610aec82610680565b6001600160a01b031614610b685760405162461bcd60e51b815260206004820152602560248201527f4552433732313a207472616e736665722066726f6d20696e636f72726563742060448201527f6f776e6572000000000000000000000000000000000000000000000000000000606482015260840161046a565b6001600160a01b038216610bca5760405162461bcd60e51b8152602060048201526024808201527f4552433732313a207472616e7366657220746f20746865207a65726f206164646044820152637265737360e01b606482015260840161046a565b610bd5600082610974565b6001600160a01b0383166000908152600360205260408120805460019290610bfe908490611662565b90915550506001600160a01b0382166000908152600360205260408120805460019290610c2c908490611679565b909155505060008181526002602052604080822080546001600160a01b0319166001600160a01b0386811691821790925591518493918716917fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef91a4505050565b6001600160a01b038216610ce35760405162461bcd60e51b815260206004820181905260248201527f4552433732313a206d696e7420746f20746865207a65726f2061646472657373604482015260640161046a565b6000818152600260205260409020546001600160a01b031615610d485760405162461bcd60e51b815260206004820152601c60248201527f4552433732313a20746f6b656e20616c7265616479206d696e74656400000000604482015260640161046a565b6001600160a01b0382166000908152600360205260408120805460019290610d71908490611679565b909155505060008181526002602052604080822080546001600160a01b0319166001600160a01b03861690811790915590518392907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef908290a45050565b6000610dda82610680565b9050610de7600083610974565b6001600160a01b0381166000908152600360205260408120805460019290610e10908490611662565b909155505060008281526002602052604080822080546001600160a01b0319169055518391906001600160a01b038416907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef908390a45050565b610e748383610c8d565b610e816000848484611165565b6105a05760405162461bcd60e51b815260206004820152603260248201527f4552433732313a207472616e7366657220746f206e6f6e20455243373231526560448201527131b2b4bb32b91034b6b83632b6b2b73a32b960711b606482015260840161046a565b610636828260405180602001604052806000815250610e6a565b816001600160a01b0316836001600160a01b03161415610f645760405162461bcd60e51b815260206004820152601960248201527f4552433732313a20617070726f766520746f2063616c6c657200000000000000604482015260640161046a565b6001600160a01b03838116600081815260056020908152604080832094871680845294825291829020805460ff191686151590811790915591519182527f17307eab39ab6107e8899845ad3d59bd9653f200f220920489ca2b5937696c31910160405180910390a3505050565b610fdc848484610ad9565b610fe884848484611165565b6108785760405162461bcd60e51b815260206004820152603260248201527f4552433732313a207472616e7366657220746f206e6f6e20455243373231526560448201527131b2b4bb32b91034b6b83632b6b2b73a32b960711b606482015260840161046a565b6060816110735750506040805180820190915260018152600360fc1b602082015290565b8160005b811561109d578061108781611691565b91506110969050600a836116c2565b9150611077565b60008167ffffffffffffffff8111156110b8576110b8611411565b6040519080825280601f01601f1916602001820160405280156110e2576020820181803683370190505b5090505b8415610ad1576110f7600183611662565b9150611104600a866116d6565b61110f906030611679565b60f81b818381518110611124576111246116ea565b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a90535061115e600a866116c2565b94506110e6565b60006001600160a01b0384163b156112b257604051630a85bd0160e11b81526001600160a01b0385169063150b7a02906111a9903390899088908890600401611700565b602060405180830381600087803b1580156111c357600080fd5b505af19250505080156111f3575060408051601f3d908101601f191682019092526111f09181019061173c565b60015b611298573d808015611221576040519150601f19603f3d011682016040523d82523d6000602084013e611226565b606091505b5080516112905760405162461bcd60e51b815260206004820152603260248201527f4552433732313a207472616e7366657220746f206e6f6e20455243373231526560448201527131b2b4bb32b91034b6b83632b6b2b73a32b960711b606482015260840161046a565b805181602001fd5b6001600160e01b031916630a85bd0160e11b149050610ad1565b506001949350505050565b6001600160e01b03198116811461065e57600080fd5b6000602082840312156112e557600080fd5b813561096d816112bd565b60005b8381101561130b5781810151838201526020016112f3565b838111156108785750506000910152565b600081518084526113348160208601602086016112f0565b601f01601f19169290920160200192915050565b60208152600061096d602083018461131c565b60006020828403121561136d57600080fd5b5035919050565b80356001600160a01b038116811461138b57600080fd5b919050565b600080604083850312156113a357600080fd5b6113ac83611374565b946020939093013593505050565b6000806000606084860312156113cf57600080fd5b6113d884611374565b92506113e660208501611374565b9150604084013590509250925092565b60006020828403121561140857600080fd5b61096d82611374565b634e487b7160e01b600052604160045260246000fd5b600082601f83011261143857600080fd5b813567ffffffffffffffff8082111561145357611453611411565b604051601f8301601f19908116603f0116810190828211818310171561147b5761147b611411565b8160405283815286602085880101111561149457600080fd5b836020870160208301376000602085830101528094505050505092915050565b6000806000606084860312156114c957600080fd5b6114d284611374565b925060208401359150604084013567ffffffffffffffff8111156114f557600080fd5b61150186828701611427565b9150509250925092565b6000806040838503121561151e57600080fd5b61152783611374565b91506020830135801515811461153c57600080fd5b809150509250929050565b6000806000806080858703121561155d57600080fd5b61156685611374565b935061157460208601611374565b925060408501359150606085013567ffffffffffffffff81111561159757600080fd5b6115a387828801611427565b91505092959194509250565b600080604083850312156115c257600080fd5b6115cb83611374565b91506115d960208401611374565b90509250929050565b600181811c908216806115f657607f821691505b6020821081141561161757634e487b7160e01b600052602260045260246000fd5b50919050565b6000835161162f8184602088016112f0565b8351908301906116438183602088016112f0565b01949350505050565b634e487b7160e01b600052601160045260246000fd5b6000828210156116745761167461164c565b500390565b6000821982111561168c5761168c61164c565b500190565b60006000198214156116a5576116a561164c565b5060010190565b634e487b7160e01b600052601260045260246000fd5b6000826116d1576116d16116ac565b500490565b6000826116e5576116e56116ac565b500690565b634e487b7160e01b600052603260045260246000fd5b60006001600160a01b03808716835280861660208401525083604083015260806060830152611732608083018461131c565b9695505050505050565b60006020828403121561174e57600080fd5b815161096d816112bd56fea164736f6c6343000809000a";

type ERC721MockConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ERC721MockConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ERC721Mock__factory extends ContractFactory {
  constructor(...args: ERC721MockConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  deploy(
    name: string,
    symbol: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ERC721Mock> {
    return super.deploy(name, symbol, overrides || {}) as Promise<ERC721Mock>;
  }
  getDeployTransaction(
    name: string,
    symbol: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(name, symbol, overrides || {});
  }
  attach(address: string): ERC721Mock {
    return super.attach(address) as ERC721Mock;
  }
  connect(signer: Signer): ERC721Mock__factory {
    return super.connect(signer) as ERC721Mock__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ERC721MockInterface {
    return new utils.Interface(_abi) as ERC721MockInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ERC721Mock {
    return new Contract(address, _abi, signerOrProvider) as ERC721Mock;
  }
}
