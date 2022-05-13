/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type { ECDSAMock, ECDSAMockInterface } from "../ECDSAMock";

const _abi = [
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "hash",
        type: "bytes32",
      },
      {
        internalType: "bytes",
        name: "signature",
        type: "bytes",
      },
    ],
    name: "recover",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "pure",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "hash",
        type: "bytes32",
      },
      {
        internalType: "bytes32",
        name: "r",
        type: "bytes32",
      },
      {
        internalType: "bytes32",
        name: "vs",
        type: "bytes32",
      },
    ],
    name: "recover_r_vs",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "pure",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "hash",
        type: "bytes32",
      },
      {
        internalType: "uint8",
        name: "v",
        type: "uint8",
      },
      {
        internalType: "bytes32",
        name: "r",
        type: "bytes32",
      },
      {
        internalType: "bytes32",
        name: "s",
        type: "bytes32",
      },
    ],
    name: "recover_v_r_s",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "pure",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "hash",
        type: "bytes32",
      },
    ],
    name: "toEthSignedMessageHash",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    stateMutability: "pure",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes",
        name: "s",
        type: "bytes",
      },
    ],
    name: "toEthSignedMessageHash",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    stateMutability: "pure",
    type: "function",
  },
];

const _bytecode =
  "0x608060405234801561001057600080fd5b506109e0806100206000396000f3fe608060405234801561001057600080fd5b50600436106100675760003560e01c8063918a15cf11610050578063918a15cf146100bc57806392bd87b5146100dd578063a005410b146100f057600080fd5b8063126442731461006c57806319045a25146100a9575b600080fd5b61007f61007a3660046106d7565b610103565b60405173ffffffffffffffffffffffffffffffffffffffff90911681526020015b60405180910390f35b61007f6100b73660046107bd565b61011a565b6100cf6100ca366004610804565b61012d565b6040519081526020016100a0565b6100cf6100eb36600461081d565b61013e565b61007f6100fe366004610852565b610149565b60006101118585858561015e565b95945050505050565b60006101268383610186565b9392505050565b6000610138826101aa565b92915050565b6000610138826101fe565b600061015684848461021c565b949350505050565b600080600061016f87878787610242565b9150915061017c8161033c565b5095945050505050565b600080600061019585856104ff565b915091506101a28161033c565b509392505050565b6040517f19457468657265756d205369676e6564204d6573736167653a0a3332000000006020820152603c8101829052600090605c015b604051602081830303815290604052805190602001209050919050565b600061020a825161056f565b826040516020016101e19291906108ae565b600080600061022c868686610685565b915091506102398161033c565b50949350505050565b6000807f7fffffffffffffffffffffffffffffff5d576e7357a4501ddfe92f46681b20a08311156102795750600090506003610333565b8460ff16601b1415801561029157508460ff16601c14155b156102a25750600090506004610333565b6040805160008082526020820180845289905260ff881692820192909252606081018690526080810185905260019060a0016020604051602081039080840390855afa1580156102f6573d6000803e3d6000fd5b5050604051601f19015191505073ffffffffffffffffffffffffffffffffffffffff811661032c57600060019250925050610333565b9150600090505b94509492505050565b600081600481111561035057610350610909565b14156103595750565b600181600481111561036d5761036d610909565b14156103c05760405162461bcd60e51b815260206004820152601860248201527f45434453413a20696e76616c6964207369676e6174757265000000000000000060448201526064015b60405180910390fd5b60028160048111156103d4576103d4610909565b14156104225760405162461bcd60e51b815260206004820152601f60248201527f45434453413a20696e76616c6964207369676e6174757265206c656e6774680060448201526064016103b7565b600381600481111561043657610436610909565b141561048f5760405162461bcd60e51b815260206004820152602260248201527f45434453413a20696e76616c6964207369676e6174757265202773272076616c604482015261756560f01b60648201526084016103b7565b60048160048111156104a3576104a3610909565b14156104fc5760405162461bcd60e51b815260206004820152602260248201527f45434453413a20696e76616c6964207369676e6174757265202776272076616c604482015261756560f01b60648201526084016103b7565b50565b6000808251604114156105365760208301516040840151606085015160001a61052a87828585610242565b94509450505050610568565b8251604014156105605760208301516040840151610555868383610685565b935093505050610568565b506000905060025b9250929050565b6060816105935750506040805180820190915260018152600360fc1b602082015290565b8160005b81156105bd57806105a781610935565b91506105b69050600a83610966565b9150610597565b60008167ffffffffffffffff8111156105d8576105d861071a565b6040519080825280601f01601f191660200182016040528015610602576020820181803683370190505b5090505b84156101565761061760018361097a565b9150610624600a86610991565b61062f9060306109a5565b60f81b818381518110610644576106446109bd565b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a90535061067e600a86610966565b9450610606565b6000807f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8316816106bb60ff86901c601b6109a5565b90506106c987828885610242565b935093505050935093915050565b600080600080608085870312156106ed57600080fd5b84359350602085013560ff8116811461070557600080fd5b93969395505050506040820135916060013590565b634e487b7160e01b600052604160045260246000fd5b600082601f83011261074157600080fd5b813567ffffffffffffffff8082111561075c5761075c61071a565b604051601f8301601f19908116603f011681019082821181831017156107845761078461071a565b8160405283815286602085880101111561079d57600080fd5b836020870160208301376000602085830101528094505050505092915050565b600080604083850312156107d057600080fd5b82359150602083013567ffffffffffffffff8111156107ee57600080fd5b6107fa85828601610730565b9150509250929050565b60006020828403121561081657600080fd5b5035919050565b60006020828403121561082f57600080fd5b813567ffffffffffffffff81111561084657600080fd5b61015684828501610730565b60008060006060848603121561086757600080fd5b505081359360208301359350604090920135919050565b60005b83811015610899578181015183820152602001610881565b838111156108a8576000848401525b50505050565b7f19457468657265756d205369676e6564204d6573736167653a0a0000000000008152600083516108e681601a85016020880161087e565b8351908301906108fd81601a84016020880161087e565b01601a01949350505050565b634e487b7160e01b600052602160045260246000fd5b634e487b7160e01b600052601160045260246000fd5b60006000198214156109495761094961091f565b5060010190565b634e487b7160e01b600052601260045260246000fd5b60008261097557610975610950565b500490565b60008282101561098c5761098c61091f565b500390565b6000826109a0576109a0610950565b500690565b600082198211156109b8576109b861091f565b500190565b634e487b7160e01b600052603260045260246000fdfea164736f6c6343000809000a";

type ECDSAMockConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ECDSAMockConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ECDSAMock__factory extends ContractFactory {
  constructor(...args: ECDSAMockConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  deploy(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ECDSAMock> {
    return super.deploy(overrides || {}) as Promise<ECDSAMock>;
  }
  getDeployTransaction(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  attach(address: string): ECDSAMock {
    return super.attach(address) as ECDSAMock;
  }
  connect(signer: Signer): ECDSAMock__factory {
    return super.connect(signer) as ECDSAMock__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ECDSAMockInterface {
    return new utils.Interface(_abi) as ECDSAMockInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ECDSAMock {
    return new Contract(address, _abi, signerOrProvider) as ECDSAMock;
  }
}
