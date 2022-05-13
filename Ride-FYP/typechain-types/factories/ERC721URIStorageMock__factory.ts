/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type {
  ERC721URIStorageMock,
  ERC721URIStorageMockInterface,
} from "../ERC721URIStorageMock";

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
        internalType: "string",
        name: "newBaseTokenURI",
        type: "string",
      },
    ],
    name: "setBaseURI",
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
      {
        internalType: "string",
        name: "_tokenURI",
        type: "string",
      },
    ],
    name: "setTokenURI",
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
  "0x60806040523480156200001157600080fd5b5060405162001ed938038062001ed98339810160408190526200003491620001e1565b8151829082906200004d9060009060208501906200006e565b508051620000639060019060208401906200006e565b505050505062000288565b8280546200007c906200024b565b90600052602060002090601f016020900481019282620000a05760008555620000eb565b82601f10620000bb57805160ff1916838001178555620000eb565b82800160010185558215620000eb579182015b82811115620000eb578251825591602001919060010190620000ce565b50620000f9929150620000fd565b5090565b5b80821115620000f95760008155600101620000fe565b634e487b7160e01b600052604160045260246000fd5b600082601f8301126200013c57600080fd5b81516001600160401b038082111562000159576200015962000114565b604051601f8301601f19908116603f0116810190828211818310171562000184576200018462000114565b81604052838152602092508683858801011115620001a157600080fd5b600091505b83821015620001c55785820183015181830184015290820190620001a6565b83821115620001d75760008385830101525b9695505050505050565b60008060408385031215620001f557600080fd5b82516001600160401b03808211156200020d57600080fd5b6200021b868387016200012a565b935060208501519150808211156200023257600080fd5b5062000241858286016200012a565b9150509250929050565b600181811c908216806200026057607f821691505b602082108114156200028257634e487b7160e01b600052602260045260246000fd5b50919050565b611c4180620002986000396000f3fe608060405234801561001057600080fd5b50600436106101775760003560e01c806355f804b3116100d857806395d89b411161008c578063b88d4fde11610066578063b88d4fde146102fb578063c87b56dd1461030e578063e985e9c51461032157600080fd5b806395d89b41146102cd578063a1448194146102d5578063a22cb465146102e857600080fd5b80636c0360eb116100bd5780636c0360eb1461029157806370a08231146102995780638832e6e3146102ba57600080fd5b806355f804b31461026b5780636352211e1461027e57600080fd5b806323b872dd1161012f57806342842e0e1161011457806342842e0e1461023257806342966c68146102455780634f558e791461025857600080fd5b806323b872dd1461020c57806340c10f191461021f57600080fd5b8063081812fc11610160578063081812fc146101b9578063095ea7b3146101e4578063162094c4146101f957600080fd5b806301ffc9a71461017c57806306fdde03146101a4575b600080fd5b61018f61018a3660046116d8565b61035d565b60405190151581526020015b60405180910390f35b6101ac6103af565b60405161019b919061174d565b6101cc6101c7366004611760565b610441565b6040516001600160a01b03909116815260200161019b565b6101f76101f2366004611795565b6104db565b005b6101f761020736600461184b565b6105f1565b6101f761021a3660046118a6565b6105ff565b6101f761022d366004611795565b610686565b6101f76102403660046118a6565b610690565b6101f7610253366004611760565b6106ab565b61018f610266366004611760565b6106b7565b6101f76102793660046118e2565b6106d6565b6101cc61028c366004611760565b6106e2565b6101ac61076d565b6102ac6102a7366004611954565b61077c565b60405190815260200161019b565b6101f76102c836600461198f565b610816565b6101ac610821565b6101f76102e3366004611795565b610830565b6101f76102f63660046119e6565b61083a565b6101f7610309366004611a22565b610845565b6101ac61031c366004611760565b6108d3565b61018f61032f366004611a8a565b6001600160a01b03918216600090815260056020908152604080832093909416825291909152205460ff1690565b60006001600160e01b031982166380ac58cd60e01b148061038e57506001600160e01b03198216635b5e139f60e01b145b806103a957506301ffc9a760e01b6001600160e01b03198316145b92915050565b6060600080546103be90611abd565b80601f01602080910402602001604051908101604052809291908181526020018280546103ea90611abd565b80156104375780601f1061040c57610100808354040283529160200191610437565b820191906000526020600020905b81548152906001019060200180831161041a57829003601f168201915b5050505050905090565b6000818152600260205260408120546001600160a01b03166104bf5760405162461bcd60e51b815260206004820152602c60248201527f4552433732313a20617070726f76656420717565727920666f72206e6f6e657860448201526b34b9ba32b73a103a37b5b2b760a11b60648201526084015b60405180910390fd5b506000908152600460205260409020546001600160a01b031690565b60006104e6826106e2565b9050806001600160a01b0316836001600160a01b031614156105545760405162461bcd60e51b815260206004820152602160248201527f4552433732313a20617070726f76616c20746f2063757272656e74206f776e656044820152603960f91b60648201526084016104b6565b336001600160a01b03821614806105705750610570813361032f565b6105e25760405162461bcd60e51b815260206004820152603860248201527f4552433732313a20617070726f76652063616c6c6572206973206e6f74206f7760448201527f6e6572206e6f7220617070726f76656420666f7220616c6c000000000000000060648201526084016104b6565b6105ec8383610a59565b505050565b6105fb8282610ac7565b5050565b6106093382610b70565b61067b5760405162461bcd60e51b815260206004820152603160248201527f4552433732313a207472616e736665722063616c6c6572206973206e6f74206f60448201527f776e6572206e6f7220617070726f76656400000000000000000000000000000060648201526084016104b6565b6105ec838383610c63565b6105fb8282610e17565b6105ec83838360405180602001604052806000815250610845565b6106b481610f59565b50565b6000818152600260205260408120546001600160a01b031615156103a9565b6105ec6007838361157f565b6000818152600260205260408120546001600160a01b0316806103a95760405162461bcd60e51b815260206004820152602960248201527f4552433732313a206f776e657220717565727920666f72206e6f6e657869737460448201527f656e7420746f6b656e000000000000000000000000000000000000000000000060648201526084016104b6565b6060610777610f99565b905090565b60006001600160a01b0382166107fa5760405162461bcd60e51b815260206004820152602a60248201527f4552433732313a2062616c616e636520717565727920666f7220746865207a6560448201527f726f20616464726573730000000000000000000000000000000000000000000060648201526084016104b6565b506001600160a01b031660009081526003602052604090205490565b6105ec838383610fa8565b6060600180546103be90611abd565b6105fb8282611026565b6105fb338383611040565b61084f3383610b70565b6108c15760405162461bcd60e51b815260206004820152603160248201527f4552433732313a207472616e736665722063616c6c6572206973206e6f74206f60448201527f776e6572206e6f7220617070726f76656400000000000000000000000000000060648201526084016104b6565b6108cd8484848461110f565b50505050565b6000818152600260205260409020546060906001600160a01b03166109605760405162461bcd60e51b815260206004820152603160248201527f45524337323155524953746f726167653a2055524920717565727920666f722060448201527f6e6f6e6578697374656e7420746f6b656e00000000000000000000000000000060648201526084016104b6565b6000828152600660205260408120805461097990611abd565b80601f01602080910402602001604051908101604052809291908181526020018280546109a590611abd565b80156109f25780601f106109c7576101008083540402835291602001916109f2565b820191906000526020600020905b8154815290600101906020018083116109d557829003601f168201915b505050505090506000610a03610f99565b9050805160001415610a16575092915050565b815115610a48578082604051602001610a30929190611af8565b60405160208183030381529060405292505050919050565b610a518461118d565b949350505050565b600081815260046020526040902080546001600160a01b0319166001600160a01b0384169081179091558190610a8e826106e2565b6001600160a01b03167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b92560405160405180910390a45050565b6000828152600260205260409020546001600160a01b0316610b515760405162461bcd60e51b815260206004820152602e60248201527f45524337323155524953746f726167653a2055524920736574206f66206e6f6e60448201527f6578697374656e7420746f6b656e00000000000000000000000000000000000060648201526084016104b6565b600082815260066020908152604090912082516105ec92840190611603565b6000818152600260205260408120546001600160a01b0316610be95760405162461bcd60e51b815260206004820152602c60248201527f4552433732313a206f70657261746f7220717565727920666f72206e6f6e657860448201526b34b9ba32b73a103a37b5b2b760a11b60648201526084016104b6565b6000610bf4836106e2565b9050806001600160a01b0316846001600160a01b03161480610c2f5750836001600160a01b0316610c2484610441565b6001600160a01b0316145b80610a5157506001600160a01b0380821660009081526005602090815260408083209388168352929052205460ff16610a51565b826001600160a01b0316610c76826106e2565b6001600160a01b031614610cf25760405162461bcd60e51b815260206004820152602560248201527f4552433732313a207472616e736665722066726f6d20696e636f72726563742060448201527f6f776e657200000000000000000000000000000000000000000000000000000060648201526084016104b6565b6001600160a01b038216610d545760405162461bcd60e51b8152602060048201526024808201527f4552433732313a207472616e7366657220746f20746865207a65726f206164646044820152637265737360e01b60648201526084016104b6565b610d5f600082610a59565b6001600160a01b0383166000908152600360205260408120805460019290610d88908490611b3d565b90915550506001600160a01b0382166000908152600360205260408120805460019290610db6908490611b54565b909155505060008181526002602052604080822080546001600160a01b0319166001600160a01b0386811691821790925591518493918716917fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef91a4505050565b6001600160a01b038216610e6d5760405162461bcd60e51b815260206004820181905260248201527f4552433732313a206d696e7420746f20746865207a65726f206164647265737360448201526064016104b6565b6000818152600260205260409020546001600160a01b031615610ed25760405162461bcd60e51b815260206004820152601c60248201527f4552433732313a20746f6b656e20616c7265616479206d696e7465640000000060448201526064016104b6565b6001600160a01b0382166000908152600360205260408120805460019290610efb908490611b54565b909155505060008181526002602052604080822080546001600160a01b0319166001600160a01b03861690811790915590518392907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef908290a45050565b610f6281611276565b60008181526006602052604090208054610f7b90611abd565b1590506106b45760008181526006602052604081206106b491611677565b6060600780546103be90611abd565b610fb28383610e17565b610fbf6000848484611311565b6105ec5760405162461bcd60e51b815260206004820152603260248201527f4552433732313a207472616e7366657220746f206e6f6e20455243373231526560448201527131b2b4bb32b91034b6b83632b6b2b73a32b960711b60648201526084016104b6565b6105fb828260405180602001604052806000815250610fa8565b816001600160a01b0316836001600160a01b031614156110a25760405162461bcd60e51b815260206004820152601960248201527f4552433732313a20617070726f766520746f2063616c6c65720000000000000060448201526064016104b6565b6001600160a01b03838116600081815260056020908152604080832094871680845294825291829020805460ff191686151590811790915591519182527f17307eab39ab6107e8899845ad3d59bd9653f200f220920489ca2b5937696c31910160405180910390a3505050565b61111a848484610c63565b61112684848484611311565b6108cd5760405162461bcd60e51b815260206004820152603260248201527f4552433732313a207472616e7366657220746f206e6f6e20455243373231526560448201527131b2b4bb32b91034b6b83632b6b2b73a32b960711b60648201526084016104b6565b6000818152600260205260409020546060906001600160a01b031661121a5760405162461bcd60e51b815260206004820152602f60248201527f4552433732314d657461646174613a2055524920717565727920666f72206e6f60448201527f6e6578697374656e7420746f6b656e000000000000000000000000000000000060648201526084016104b6565b6000611224610f99565b90506000815111611244576040518060200160405280600081525061126f565b8061124e84611469565b60405160200161125f929190611af8565b6040516020818303038152906040525b9392505050565b6000611281826106e2565b905061128e600083610a59565b6001600160a01b03811660009081526003602052604081208054600192906112b7908490611b3d565b909155505060008281526002602052604080822080546001600160a01b0319169055518391906001600160a01b038416907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef908390a45050565b60006001600160a01b0384163b1561145e57604051630a85bd0160e11b81526001600160a01b0385169063150b7a0290611355903390899088908890600401611b6c565b602060405180830381600087803b15801561136f57600080fd5b505af192505050801561139f575060408051601f3d908101601f1916820190925261139c91810190611ba8565b60015b611444573d8080156113cd576040519150601f19603f3d011682016040523d82523d6000602084013e6113d2565b606091505b50805161143c5760405162461bcd60e51b815260206004820152603260248201527f4552433732313a207472616e7366657220746f206e6f6e20455243373231526560448201527131b2b4bb32b91034b6b83632b6b2b73a32b960711b60648201526084016104b6565b805181602001fd5b6001600160e01b031916630a85bd0160e11b149050610a51565b506001949350505050565b60608161148d5750506040805180820190915260018152600360fc1b602082015290565b8160005b81156114b757806114a181611bc5565b91506114b09050600a83611bf6565b9150611491565b60008167ffffffffffffffff8111156114d2576114d26117bf565b6040519080825280601f01601f1916602001820160405280156114fc576020820181803683370190505b5090505b8415610a5157611511600183611b3d565b915061151e600a86611c0a565b611529906030611b54565b60f81b81838151811061153e5761153e611c1e565b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a905350611578600a86611bf6565b9450611500565b82805461158b90611abd565b90600052602060002090601f0160209004810192826115ad57600085556115f3565b82601f106115c65782800160ff198235161785556115f3565b828001600101855582156115f3579182015b828111156115f35782358255916020019190600101906115d8565b506115ff9291506116ad565b5090565b82805461160f90611abd565b90600052602060002090601f01602090048101928261163157600085556115f3565b82601f1061164a57805160ff19168380011785556115f3565b828001600101855582156115f3579182015b828111156115f357825182559160200191906001019061165c565b50805461168390611abd565b6000825580601f10611693575050565b601f0160209004906000526020600020908101906106b491905b5b808211156115ff57600081556001016116ae565b6001600160e01b0319811681146106b457600080fd5b6000602082840312156116ea57600080fd5b813561126f816116c2565b60005b838110156117105781810151838201526020016116f8565b838111156108cd5750506000910152565b600081518084526117398160208601602086016116f5565b601f01601f19169290920160200192915050565b60208152600061126f6020830184611721565b60006020828403121561177257600080fd5b5035919050565b80356001600160a01b038116811461179057600080fd5b919050565b600080604083850312156117a857600080fd5b6117b183611779565b946020939093013593505050565b634e487b7160e01b600052604160045260246000fd5b600067ffffffffffffffff808411156117f0576117f06117bf565b604051601f8501601f19908116603f01168101908282118183101715611818576118186117bf565b8160405280935085815286868601111561183157600080fd5b858560208301376000602087830101525050509392505050565b6000806040838503121561185e57600080fd5b82359150602083013567ffffffffffffffff81111561187c57600080fd5b8301601f8101851361188d57600080fd5b61189c858235602084016117d5565b9150509250929050565b6000806000606084860312156118bb57600080fd5b6118c484611779565b92506118d260208501611779565b9150604084013590509250925092565b600080602083850312156118f557600080fd5b823567ffffffffffffffff8082111561190d57600080fd5b818501915085601f83011261192157600080fd5b81358181111561193057600080fd5b86602082850101111561194257600080fd5b60209290920196919550909350505050565b60006020828403121561196657600080fd5b61126f82611779565b600082601f83011261198057600080fd5b61126f838335602085016117d5565b6000806000606084860312156119a457600080fd5b6119ad84611779565b925060208401359150604084013567ffffffffffffffff8111156119d057600080fd5b6119dc8682870161196f565b9150509250925092565b600080604083850312156119f957600080fd5b611a0283611779565b915060208301358015158114611a1757600080fd5b809150509250929050565b60008060008060808587031215611a3857600080fd5b611a4185611779565b9350611a4f60208601611779565b925060408501359150606085013567ffffffffffffffff811115611a7257600080fd5b611a7e8782880161196f565b91505092959194509250565b60008060408385031215611a9d57600080fd5b611aa683611779565b9150611ab460208401611779565b90509250929050565b600181811c90821680611ad157607f821691505b60208210811415611af257634e487b7160e01b600052602260045260246000fd5b50919050565b60008351611b0a8184602088016116f5565b835190830190611b1e8183602088016116f5565b01949350505050565b634e487b7160e01b600052601160045260246000fd5b600082821015611b4f57611b4f611b27565b500390565b60008219821115611b6757611b67611b27565b500190565b60006001600160a01b03808716835280861660208401525083604083015260806060830152611b9e6080830184611721565b9695505050505050565b600060208284031215611bba57600080fd5b815161126f816116c2565b6000600019821415611bd957611bd9611b27565b5060010190565b634e487b7160e01b600052601260045260246000fd5b600082611c0557611c05611be0565b500490565b600082611c1957611c19611be0565b500690565b634e487b7160e01b600052603260045260246000fdfea164736f6c6343000809000a";

type ERC721URIStorageMockConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ERC721URIStorageMockConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ERC721URIStorageMock__factory extends ContractFactory {
  constructor(...args: ERC721URIStorageMockConstructorParams) {
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
  ): Promise<ERC721URIStorageMock> {
    return super.deploy(
      name,
      symbol,
      overrides || {}
    ) as Promise<ERC721URIStorageMock>;
  }
  getDeployTransaction(
    name: string,
    symbol: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(name, symbol, overrides || {});
  }
  attach(address: string): ERC721URIStorageMock {
    return super.attach(address) as ERC721URIStorageMock;
  }
  connect(signer: Signer): ERC721URIStorageMock__factory {
    return super.connect(signer) as ERC721URIStorageMock__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ERC721URIStorageMockInterface {
    return new utils.Interface(_abi) as ERC721URIStorageMockInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ERC721URIStorageMock {
    return new Contract(
      address,
      _abi,
      signerOrProvider
    ) as ERC721URIStorageMock;
  }
}
