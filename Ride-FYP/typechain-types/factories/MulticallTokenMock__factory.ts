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
import type {
  MulticallTokenMock,
  MulticallTokenMockInterface,
} from "../MulticallTokenMock";

const _abi = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "initialBalance",
        type: "uint256",
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
        name: "owner",
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
        name: "amount",
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
        name: "owner",
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
        name: "account",
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
        internalType: "address",
        name: "account",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
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
        name: "subtractedValue",
        type: "uint256",
      },
    ],
    name: "decreaseAllowance",
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
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "addedValue",
        type: "uint256",
      },
    ],
    name: "increaseAllowance",
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
        name: "account",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "mint",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes[]",
        name: "data",
        type: "bytes[]",
      },
    ],
    name: "multicall",
    outputs: [
      {
        internalType: "bytes[]",
        name: "results",
        type: "bytes[]",
      },
    ],
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
        name: "value",
        type: "uint256",
      },
    ],
    name: "transferInternal",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x60806040523480156200001157600080fd5b506040516200132a3803806200132a833981016040819052620000349162000257565b6040518060400160405280600e81526020016d26bab63a34b1b0b6362a37b5b2b760911b815250604051806040016040528060038152602001621090d560ea1b81525033838383816003908051906020019062000093929190620001b1565b508051620000a9906004906020840190620001b1565b505050620000be8282620000c960201b60201c565b5050505050620002d5565b6001600160a01b038216620001245760405162461bcd60e51b815260206004820152601f60248201527f45524332303a206d696e7420746f20746865207a65726f206164647265737300604482015260640160405180910390fd5b806002600082825462000138919062000271565b90915550506001600160a01b038216600090815260208190526040812080548392906200016790849062000271565b90915550506040518181526001600160a01b038316906000907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9060200160405180910390a35050565b828054620001bf9062000298565b90600052602060002090601f016020900481019282620001e357600085556200022e565b82601f10620001fe57805160ff19168380011785556200022e565b828001600101855582156200022e579182015b828111156200022e57825182559160200191906001019062000211565b506200023c92915062000240565b5090565b5b808211156200023c576000815560010162000241565b6000602082840312156200026a57600080fd5b5051919050565b600082198211156200029357634e487b7160e01b600052601160045260246000fd5b500190565b600181811c90821680620002ad57607f821691505b60208210811415620002cf57634e487b7160e01b600052602260045260246000fd5b50919050565b61104580620002e56000396000f3fe608060405234801561001057600080fd5b50600436106101005760003560e01c806356189cb411610097578063a457c2d711610066578063a457c2d71461020c578063a9059cbb1461021f578063ac9650d814610232578063dd62ed3e1461025257600080fd5b806356189cb4146101b557806370a08231146101c857806395d89b41146101f15780639dc29fac146101f957600080fd5b806323b872dd116100d357806323b872dd1461016d578063313ce56714610180578063395093511461018f57806340c10f19146101a257600080fd5b806306fdde0314610105578063095ea7b31461012357806318160ddd14610146578063222f5be014610158575b600080fd5b61010d61028b565b60405161011a9190610d26565b60405180910390f35b610136610131366004610d55565b61031d565b604051901515815260200161011a565b6002545b60405190815260200161011a565b61016b610166366004610d7f565b610333565b005b61013661017b366004610d7f565b610343565b6040516012815260200161011a565b61013661019d366004610d55565b610410565b61016b6101b0366004610d55565b61044c565b61016b6101c3366004610d7f565b61045a565b61014a6101d6366004610dbb565b6001600160a01b031660009081526020819052604090205490565b61010d610465565b61016b610207366004610d55565b610474565b61013661021a366004610d55565b61047e565b61013661022d366004610d55565b61052f565b610245610240366004610dd6565b61053c565b60405161011a9190610e4b565b61014a610260366004610ead565b6001600160a01b03918216600090815260016020908152604080832093909416825291909152205490565b60606003805461029a90610ee0565b80601f01602080910402602001604051908101604052809291908181526020018280546102c690610ee0565b80156103135780601f106102e857610100808354040283529160200191610313565b820191906000526020600020905b8154815290600101906020018083116102f657829003601f168201915b5050505050905090565b600061032a338484610631565b50600192915050565b61033e838383610755565b505050565b6001600160a01b038316600090815260016020908152604080832033845290915281205460001981146103f857828110156103eb5760405162461bcd60e51b815260206004820152602860248201527f45524332303a207472616e7366657220616d6f756e742065786365656473206160448201527f6c6c6f77616e636500000000000000000000000000000000000000000000000060648201526084015b60405180910390fd5b6103f88533858403610631565b610403858585610755565b60019150505b9392505050565b3360008181526001602090815260408083206001600160a01b0387168452909152812054909161032a918590610447908690610f31565b610631565b6104568282610954565b5050565b61033e838383610631565b60606004805461029a90610ee0565b6104568282610a33565b3360009081526001602090815260408083206001600160a01b0386168452909152812054828110156105185760405162461bcd60e51b815260206004820152602560248201527f45524332303a2064656372656173656420616c6c6f77616e63652062656c6f7760448201527f207a65726f00000000000000000000000000000000000000000000000000000060648201526084016103e2565b6105253385858403610631565b5060019392505050565b600061032a338484610755565b60608167ffffffffffffffff81111561055757610557610f49565b60405190808252806020026020018201604052801561058a57816020015b60608152602001906001900390816105755790505b50905060005b8281101561062a576105fa308585848181106105ae576105ae610f5f565b90506020028101906105c09190610f75565b8080601f016020809104026020016040519081016040528093929190818152602001838380828437600092019190915250610b8192505050565b82828151811061060c5761060c610f5f565b6020026020010181905250808061062290610fc3565b915050610590565b5092915050565b6001600160a01b0383166106935760405162461bcd60e51b8152602060048201526024808201527f45524332303a20617070726f76652066726f6d20746865207a65726f206164646044820152637265737360e01b60648201526084016103e2565b6001600160a01b0382166106f45760405162461bcd60e51b815260206004820152602260248201527f45524332303a20617070726f766520746f20746865207a65726f206164647265604482015261737360f01b60648201526084016103e2565b6001600160a01b0383811660008181526001602090815260408083209487168084529482529182902085905590518481527f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925910160405180910390a3505050565b6001600160a01b0383166107d15760405162461bcd60e51b815260206004820152602560248201527f45524332303a207472616e736665722066726f6d20746865207a65726f20616460448201527f647265737300000000000000000000000000000000000000000000000000000060648201526084016103e2565b6001600160a01b0382166108335760405162461bcd60e51b815260206004820152602360248201527f45524332303a207472616e7366657220746f20746865207a65726f206164647260448201526265737360e81b60648201526084016103e2565b6001600160a01b038316600090815260208190526040902054818110156108c25760405162461bcd60e51b815260206004820152602660248201527f45524332303a207472616e7366657220616d6f756e742065786365656473206260448201527f616c616e6365000000000000000000000000000000000000000000000000000060648201526084016103e2565b6001600160a01b038085166000908152602081905260408082208585039055918516815290812080548492906108f9908490610f31565b92505081905550826001600160a01b0316846001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef8460405161094591815260200190565b60405180910390a35b50505050565b6001600160a01b0382166109aa5760405162461bcd60e51b815260206004820152601f60248201527f45524332303a206d696e7420746f20746865207a65726f20616464726573730060448201526064016103e2565b80600260008282546109bc9190610f31565b90915550506001600160a01b038216600090815260208190526040812080548392906109e9908490610f31565b90915550506040518181526001600160a01b038316906000907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9060200160405180910390a35050565b6001600160a01b038216610a935760405162461bcd60e51b815260206004820152602160248201527f45524332303a206275726e2066726f6d20746865207a65726f206164647265736044820152607360f81b60648201526084016103e2565b6001600160a01b03821660009081526020819052604090205481811015610b075760405162461bcd60e51b815260206004820152602260248201527f45524332303a206275726e20616d6f756e7420657863656564732062616c616e604482015261636560f01b60648201526084016103e2565b6001600160a01b0383166000908152602081905260408120838303905560028054849290610b36908490610fde565b90915550506040518281526000906001600160a01b038516907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9060200160405180910390a3505050565b606061040983836040518060600160405280602781526020016110126027913960606001600160a01b0384163b610c205760405162461bcd60e51b815260206004820152602660248201527f416464726573733a2064656c65676174652063616c6c20746f206e6f6e2d636f60448201527f6e7472616374000000000000000000000000000000000000000000000000000060648201526084016103e2565b600080856001600160a01b031685604051610c3b9190610ff5565b600060405180830381855af49150503d8060008114610c76576040519150601f19603f3d011682016040523d82523d6000602084013e610c7b565b606091505b5091509150610c8b828286610c95565b9695505050505050565b60608315610ca4575081610409565b825115610cb45782518084602001fd5b8160405162461bcd60e51b81526004016103e29190610d26565b60005b83811015610ce9578181015183820152602001610cd1565b8381111561094e5750506000910152565b60008151808452610d12816020860160208601610cce565b601f01601f19169290920160200192915050565b6020815260006104096020830184610cfa565b80356001600160a01b0381168114610d5057600080fd5b919050565b60008060408385031215610d6857600080fd5b610d7183610d39565b946020939093013593505050565b600080600060608486031215610d9457600080fd5b610d9d84610d39565b9250610dab60208501610d39565b9150604084013590509250925092565b600060208284031215610dcd57600080fd5b61040982610d39565b60008060208385031215610de957600080fd5b823567ffffffffffffffff80821115610e0157600080fd5b818501915085601f830112610e1557600080fd5b813581811115610e2457600080fd5b8660208260051b8501011115610e3957600080fd5b60209290920196919550909350505050565b6000602080830181845280855180835260408601915060408160051b870101925083870160005b82811015610ea057603f19888603018452610e8e858351610cfa565b94509285019290850190600101610e72565b5092979650505050505050565b60008060408385031215610ec057600080fd5b610ec983610d39565b9150610ed760208401610d39565b90509250929050565b600181811c90821680610ef457607f821691505b60208210811415610f1557634e487b7160e01b600052602260045260246000fd5b50919050565b634e487b7160e01b600052601160045260246000fd5b60008219821115610f4457610f44610f1b565b500190565b634e487b7160e01b600052604160045260246000fd5b634e487b7160e01b600052603260045260246000fd5b6000808335601e19843603018112610f8c57600080fd5b83018035915067ffffffffffffffff821115610fa757600080fd5b602001915036819003821315610fbc57600080fd5b9250929050565b6000600019821415610fd757610fd7610f1b565b5060010190565b600082821015610ff057610ff0610f1b565b500390565b60008251611007818460208701610cce565b919091019291505056fe416464726573733a206c6f772d6c6576656c2064656c65676174652063616c6c206661696c6564a164736f6c6343000809000a";

type MulticallTokenMockConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: MulticallTokenMockConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class MulticallTokenMock__factory extends ContractFactory {
  constructor(...args: MulticallTokenMockConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  deploy(
    initialBalance: BigNumberish,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<MulticallTokenMock> {
    return super.deploy(
      initialBalance,
      overrides || {}
    ) as Promise<MulticallTokenMock>;
  }
  getDeployTransaction(
    initialBalance: BigNumberish,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(initialBalance, overrides || {});
  }
  attach(address: string): MulticallTokenMock {
    return super.attach(address) as MulticallTokenMock;
  }
  connect(signer: Signer): MulticallTokenMock__factory {
    return super.connect(signer) as MulticallTokenMock__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): MulticallTokenMockInterface {
    return new utils.Interface(_abi) as MulticallTokenMockInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): MulticallTokenMock {
    return new Contract(address, _abi, signerOrProvider) as MulticallTokenMock;
  }
}
