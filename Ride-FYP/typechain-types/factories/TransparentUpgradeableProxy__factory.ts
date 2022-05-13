/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Signer,
  utils,
  Contract,
  ContractFactory,
  PayableOverrides,
  BytesLike,
} from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type {
  TransparentUpgradeableProxy,
  TransparentUpgradeableProxyInterface,
} from "../TransparentUpgradeableProxy";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_logic",
        type: "address",
      },
      {
        internalType: "address",
        name: "admin_",
        type: "address",
      },
      {
        internalType: "bytes",
        name: "_data",
        type: "bytes",
      },
    ],
    stateMutability: "payable",
    type: "constructor",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "previousAdmin",
        type: "address",
      },
      {
        indexed: false,
        internalType: "address",
        name: "newAdmin",
        type: "address",
      },
    ],
    name: "AdminChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "beacon",
        type: "address",
      },
    ],
    name: "BeaconUpgraded",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "implementation",
        type: "address",
      },
    ],
    name: "Upgraded",
    type: "event",
  },
  {
    stateMutability: "payable",
    type: "fallback",
  },
  {
    inputs: [],
    name: "admin",
    outputs: [
      {
        internalType: "address",
        name: "admin_",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "newAdmin",
        type: "address",
      },
    ],
    name: "changeAdmin",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "implementation",
    outputs: [
      {
        internalType: "address",
        name: "implementation_",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "newImplementation",
        type: "address",
      },
    ],
    name: "upgradeTo",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "newImplementation",
        type: "address",
      },
      {
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
    ],
    name: "upgradeToAndCall",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    stateMutability: "payable",
    type: "receive",
  },
];

const _bytecode =
  "0x608060405260405162000fa338038062000fa3833981016040819052620000269162000519565b82816200005560017f360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbd620005f9565b60008051602062000f5c833981519152146200007557620000756200061f565b6200008382826000620000e7565b50620000b3905060017fb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6104620005f9565b60008051602062000f3c83398151915214620000d357620000d36200061f565b620000de8262000124565b50505062000688565b620000f2836200017f565b600082511180620001005750805b156200011f576200011d8383620001c160201b620002701760201c565b505b505050565b7f7e644d79422f17c01e4894b5f4f588d331ebfa28653d42ae832dc59e38c9798f6200014f620001f0565b604080516001600160a01b03928316815291841660208301520160405180910390a16200017c8162000229565b50565b6200018a81620002de565b6040516001600160a01b038216907fbc7cd75a20ee27fd9adebab32041f755214dbc6bffa90cc0225b39da2e5c2d3b90600090a250565b6060620001e9838360405180606001604052806027815260200162000f7c6027913962000381565b9392505050565b60006200021a60008051602062000f3c83398151915260001b6200046760201b620002181760201c565b546001600160a01b0316919050565b6001600160a01b038116620002945760405162461bcd60e51b815260206004820152602660248201527f455243313936373a206e65772061646d696e20697320746865207a65726f206160448201526564647265737360d01b60648201526084015b60405180910390fd5b80620002bd60008051602062000f3c83398151915260001b6200046760201b620002181760201c565b80546001600160a01b0319166001600160a01b039290921691909117905550565b620002f4816200046a60201b6200029c1760201c565b620003585760405162461bcd60e51b815260206004820152602d60248201527f455243313936373a206e657720696d706c656d656e746174696f6e206973206e60448201526c1bdd08184818dbdb9d1c9858dd609a1b60648201526084016200028b565b80620002bd60008051602062000f5c83398151915260001b6200046760201b620002181760201c565b60606001600160a01b0384163b620003eb5760405162461bcd60e51b815260206004820152602660248201527f416464726573733a2064656c65676174652063616c6c20746f206e6f6e2d636f6044820152651b9d1c9858dd60d21b60648201526084016200028b565b600080856001600160a01b03168560405162000408919062000635565b600060405180830381855af49150503d806000811462000445576040519150601f19603f3d011682016040523d82523d6000602084013e6200044a565b606091505b5090925090506200045d82828662000479565b9695505050505050565b90565b6001600160a01b03163b151590565b606083156200048a575081620001e9565b8251156200049b5782518084602001fd5b8160405162461bcd60e51b81526004016200028b919062000653565b80516001600160a01b0381168114620004cf57600080fd5b919050565b634e487b7160e01b600052604160045260246000fd5b60005b8381101562000507578181015183820152602001620004ed565b838111156200011d5750506000910152565b6000806000606084860312156200052f57600080fd5b6200053a84620004b7565b92506200054a60208501620004b7565b60408501519092506001600160401b03808211156200056857600080fd5b818601915086601f8301126200057d57600080fd5b815181811115620005925762000592620004d4565b604051601f8201601f19908116603f01168101908382118183101715620005bd57620005bd620004d4565b81604052828152896020848701011115620005d757600080fd5b620005ea836020830160208801620004ea565b80955050505050509250925092565b6000828210156200061a57634e487b7160e01b600052601160045260246000fd5b500390565b634e487b7160e01b600052600160045260246000fd5b6000825162000649818460208701620004ea565b9190910192915050565b602081526000825180602084015262000674816040850160208701620004ea565b601f01601f19169190910160400192915050565b6108a480620006986000396000f3fe60806040526004361061005e5760003560e01c80635c60da1b116100435780635c60da1b146100a85780638f283970146100d9578063f851a440146100f95761006d565b80633659cfe6146100755780634f1ef286146100955761006d565b3661006d5761006b61010e565b005b61006b61010e565b34801561008157600080fd5b5061006b610090366004610757565b610128565b61006b6100a3366004610772565b61016f565b3480156100b457600080fd5b506100bd6101e0565b6040516001600160a01b03909116815260200160405180910390f35b3480156100e557600080fd5b5061006b6100f4366004610757565b61021b565b34801561010557600080fd5b506100bd610245565b6101166102ab565b61012661012161034a565b610354565b565b610130610378565b6001600160a01b0316336001600160a01b0316141561016757610164816040518060200160405280600081525060006103ab565b50565b61016461010e565b610177610378565b6001600160a01b0316336001600160a01b031614156101d8576101d38383838080601f016020809104026020016040519081016040528093929190818152602001838380828437600092019190915250600192506103ab915050565b505050565b6101d361010e565b60006101ea610378565b6001600160a01b0316336001600160a01b031614156102105761020b61034a565b905090565b61021861010e565b90565b610223610378565b6001600160a01b0316336001600160a01b0316141561016757610164816103d6565b600061024f610378565b6001600160a01b0316336001600160a01b031614156102105761020b610378565b606061029583836040518060600160405280602781526020016108716027913961042a565b9392505050565b6001600160a01b03163b151590565b6102b3610378565b6001600160a01b0316336001600160a01b031614156101265760405162461bcd60e51b815260206004820152604260248201527f5472616e73706172656e745570677261646561626c6550726f78793a2061646d60448201527f696e2063616e6e6f742066616c6c6261636b20746f2070726f78792074617267606482015261195d60f21b608482015260a4015b60405180910390fd5b600061020b61051e565b3660008037600080366000845af43d6000803e808015610373573d6000f35b3d6000fd5b60007fb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d61035b546001600160a01b0316919050565b6103b483610546565b6000825111806103c15750805b156101d3576103d08383610270565b50505050565b7f7e644d79422f17c01e4894b5f4f588d331ebfa28653d42ae832dc59e38c9798f6103ff610378565b604080516001600160a01b03928316815291841660208301520160405180910390a161016481610586565b60606001600160a01b0384163b6104a95760405162461bcd60e51b815260206004820152602660248201527f416464726573733a2064656c65676174652063616c6c20746f206e6f6e2d636f60448201527f6e747261637400000000000000000000000000000000000000000000000000006064820152608401610341565b600080856001600160a01b0316856040516104c49190610821565b600060405180830381855af49150503d80600081146104ff576040519150601f19603f3d011682016040523d82523d6000602084013e610504565b606091505b509150915061051482828661065e565b9695505050505050565b60007f360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc61039c565b61054f81610697565b6040516001600160a01b038216907fbc7cd75a20ee27fd9adebab32041f755214dbc6bffa90cc0225b39da2e5c2d3b90600090a250565b6001600160a01b0381166106025760405162461bcd60e51b815260206004820152602660248201527f455243313936373a206e65772061646d696e20697320746865207a65726f206160448201527f64647265737300000000000000000000000000000000000000000000000000006064820152608401610341565b807fb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d61035b80547fffffffffffffffffffffffff0000000000000000000000000000000000000000166001600160a01b039290921691909117905550565b6060831561066d575081610295565b82511561067d5782518084602001fd5b8160405162461bcd60e51b8152600401610341919061083d565b6001600160a01b0381163b6107145760405162461bcd60e51b815260206004820152602d60248201527f455243313936373a206e657720696d706c656d656e746174696f6e206973206e60448201527f6f74206120636f6e7472616374000000000000000000000000000000000000006064820152608401610341565b807f360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc610625565b80356001600160a01b038116811461075257600080fd5b919050565b60006020828403121561076957600080fd5b6102958261073b565b60008060006040848603121561078757600080fd5b6107908461073b565b9250602084013567ffffffffffffffff808211156107ad57600080fd5b818601915086601f8301126107c157600080fd5b8135818111156107d057600080fd5b8760208285010111156107e257600080fd5b6020830194508093505050509250925092565b60005b838110156108105781810151838201526020016107f8565b838111156103d05750506000910152565b600082516108338184602087016107f5565b9190910192915050565b602081526000825180602084015261085c8160408501602087016107f5565b601f01601f1916919091016040019291505056fe416464726573733a206c6f772d6c6576656c2064656c65676174652063616c6c206661696c6564a164736f6c6343000809000ab53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc416464726573733a206c6f772d6c6576656c2064656c65676174652063616c6c206661696c6564";

type TransparentUpgradeableProxyConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: TransparentUpgradeableProxyConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class TransparentUpgradeableProxy__factory extends ContractFactory {
  constructor(...args: TransparentUpgradeableProxyConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  deploy(
    _logic: string,
    admin_: string,
    _data: BytesLike,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<TransparentUpgradeableProxy> {
    return super.deploy(
      _logic,
      admin_,
      _data,
      overrides || {}
    ) as Promise<TransparentUpgradeableProxy>;
  }
  getDeployTransaction(
    _logic: string,
    admin_: string,
    _data: BytesLike,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(_logic, admin_, _data, overrides || {});
  }
  attach(address: string): TransparentUpgradeableProxy {
    return super.attach(address) as TransparentUpgradeableProxy;
  }
  connect(signer: Signer): TransparentUpgradeableProxy__factory {
    return super.connect(signer) as TransparentUpgradeableProxy__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): TransparentUpgradeableProxyInterface {
    return new utils.Interface(_abi) as TransparentUpgradeableProxyInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): TransparentUpgradeableProxy {
    return new Contract(
      address,
      _abi,
      signerOrProvider
    ) as TransparentUpgradeableProxy;
  }
}
