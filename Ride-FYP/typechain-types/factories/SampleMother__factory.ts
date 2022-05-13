/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type { SampleMother, SampleMotherInterface } from "../SampleMother";

const _abi = [
  {
    inputs: [],
    name: "initialize",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "initialize",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "isHuman",
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
    name: "mother",
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
];

const _bytecode =
  "0x608060405234801561001057600080fd5b5061043b806100206000396000f3fe608060405234801561001057600080fd5b506004361061004c5760003560e01c80634a6c9db6146100515780638129fc1c14610079578063ed7dfee314610083578063fe4b84df1461009a575b600080fd5b6000546100649062010000900460ff1681565b60405190151581526020015b60405180910390f35b6100816100ad565b005b61008c60015481565b604051908152602001610070565b6100816100a8366004610415565b610173565b600054610100900460ff166100c85760005460ff16156100cc565b303b155b6101345760405162461bcd60e51b815260206004820152602e60248201527f496e697469616c697a61626c653a20636f6e747261637420697320616c72656160448201526d191e481a5b9a5d1a585b1a5e995960921b60648201526084015b60405180910390fd5b600054610100900460ff16158015610156576000805461ffff19166101011790555b61015e610236565b8015610170576000805461ff00191690555b50565b600054610100900460ff1661018e5760005460ff1615610192565b303b155b6101f55760405162461bcd60e51b815260206004820152602e60248201527f496e697469616c697a61626c653a20636f6e747261637420697320616c72656160448201526d191e481a5b9a5d1a585b1a5e995960921b606482015260840161012b565b600054610100900460ff16158015610217576000805461ffff19166101011790555b610220826102ab565b8015610232576000805461ff00191690555b5050565b600054610100900460ff166102a15760405162461bcd60e51b815260206004820152602b60248201527f496e697469616c697a61626c653a20636f6e7472616374206973206e6f74206960448201526a6e697469616c697a696e6760a81b606482015260840161012b565b6102a9610327565b565b600054610100900460ff166103165760405162461bcd60e51b815260206004820152602b60248201527f496e697469616c697a61626c653a20636f6e7472616374206973206e6f74206960448201526a6e697469616c697a696e6760a81b606482015260840161012b565b61031e610236565b610170816103a5565b600054610100900460ff166103925760405162461bcd60e51b815260206004820152602b60248201527f496e697469616c697a61626c653a20636f6e7472616374206973206e6f74206960448201526a6e697469616c697a696e6760a81b606482015260840161012b565b6000805462ff0000191662010000179055565b600054610100900460ff166104105760405162461bcd60e51b815260206004820152602b60248201527f496e697469616c697a61626c653a20636f6e7472616374206973206e6f74206960448201526a6e697469616c697a696e6760a81b606482015260840161012b565b600155565b60006020828403121561042757600080fd5b503591905056fea164736f6c6343000809000a";

type SampleMotherConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: SampleMotherConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class SampleMother__factory extends ContractFactory {
  constructor(...args: SampleMotherConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  deploy(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<SampleMother> {
    return super.deploy(overrides || {}) as Promise<SampleMother>;
  }
  getDeployTransaction(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  attach(address: string): SampleMother {
    return super.attach(address) as SampleMother;
  }
  connect(signer: Signer): SampleMother__factory {
    return super.connect(signer) as SampleMother__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): SampleMotherInterface {
    return new utils.Interface(_abi) as SampleMotherInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): SampleMother {
    return new Contract(address, _abi, signerOrProvider) as SampleMother;
  }
}
