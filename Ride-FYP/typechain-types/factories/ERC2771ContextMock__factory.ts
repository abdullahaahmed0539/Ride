/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type {
  ERC2771ContextMock,
  ERC2771ContextMockInterface,
} from "../ERC2771ContextMock";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "trustedForwarder",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "integerValue",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "string",
        name: "stringValue",
        type: "string",
      },
    ],
    name: "Data",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "sender",
        type: "address",
      },
    ],
    name: "Sender",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "forwarder",
        type: "address",
      },
    ],
    name: "isTrustedForwarder",
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
        name: "integerValue",
        type: "uint256",
      },
      {
        internalType: "string",
        name: "stringValue",
        type: "string",
      },
    ],
    name: "msgData",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "msgSender",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x60a060405234801561001057600080fd5b5060405161051c38038061051c83398101604081905261002f916100d8565b6001600160a01b0381166080527fd6558c3ed910d959271054471fd1c326679d9fece99c5091b00ed89627cf2bfc610065610086565b6040516001600160a01b03909116815260200160405180910390a150610108565b600061009a61009f60201b6101441760201c565b905090565b6080516000906001600160a01b03163314156100c2575060131936013560601c90565b61009a6100d460201b61018e1760201c565b3390565b6000602082840312156100ea57600080fd5b81516001600160a01b038116811461010157600080fd5b9392505050565b6080516103ec61013060003960008181606b0152818161014801526101b401526103ec6000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c8063376bf26214610046578063572b6c051461005b578063d737d0c7146100af575b600080fd5b61005961005436600461021d565b6100b7565b005b61009b6100693660046102d8565b7f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0390811691161490565b604051901515815260200160405180910390f35b6100596100fe565b7faf235354a0a47c91ee171961326335cb2d1a8e55b8a89859b0e61eb049e50ea06100e0610192565b84846040516100f29493929190610308565b60405180910390a15050565b7fd6558c3ed910d959271054471fd1c326679d9fece99c5091b00ed89627cf2bfc6101276101a5565b6040516001600160a01b03909116815260200160405180910390a1565b60007f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316331415610184575060131936013560601c90565b503390565b905090565b3390565b36600061019d6101af565b915091509091565b6000610189610144565b3660007f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03163314156101ff57600080366101f2601482610390565b9261019d939291906103b5565b60003661019d565b634e487b7160e01b600052604160045260246000fd5b6000806040838503121561023057600080fd5b82359150602083013567ffffffffffffffff8082111561024f57600080fd5b818501915085601f83011261026357600080fd5b81358181111561027557610275610207565b604051601f8201601f19908116603f0116810190838211818310171561029d5761029d610207565b816040528281528860208487010111156102b657600080fd5b8260208601602083013760006020848301015280955050505050509250929050565b6000602082840312156102ea57600080fd5b81356001600160a01b038116811461030157600080fd5b9392505050565b60608152836060820152838560808301376000608085830101526000601f1980601f8701168301602086818601526080858303016040860152855180608084015260005b818110156103685787810183015184820160a00152820161034c565b8181111561037a57600060a083860101525b50601f019092160160a001979650505050505050565b6000828210156103b057634e487b7160e01b600052601160045260246000fd5b500390565b600080858511156103c557600080fd5b838611156103d257600080fd5b505082019391909203915056fea164736f6c6343000809000a";

type ERC2771ContextMockConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ERC2771ContextMockConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ERC2771ContextMock__factory extends ContractFactory {
  constructor(...args: ERC2771ContextMockConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  deploy(
    trustedForwarder: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ERC2771ContextMock> {
    return super.deploy(
      trustedForwarder,
      overrides || {}
    ) as Promise<ERC2771ContextMock>;
  }
  getDeployTransaction(
    trustedForwarder: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(trustedForwarder, overrides || {});
  }
  attach(address: string): ERC2771ContextMock {
    return super.attach(address) as ERC2771ContextMock;
  }
  connect(signer: Signer): ERC2771ContextMock__factory {
    return super.connect(signer) as ERC2771ContextMock__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ERC2771ContextMockInterface {
    return new utils.Interface(_abi) as ERC2771ContextMockInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ERC2771ContextMock {
    return new Contract(address, _abi, signerOrProvider) as ERC2771ContextMock;
  }
}
