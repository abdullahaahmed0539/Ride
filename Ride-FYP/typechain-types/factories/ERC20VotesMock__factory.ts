/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type {
  ERC20VotesMock,
  ERC20VotesMockInterface,
} from "../ERC20VotesMock";

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
        name: "delegator",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "fromDelegate",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "toDelegate",
        type: "address",
      },
    ],
    name: "DelegateChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "delegate",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "previousBalance",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "newBalance",
        type: "uint256",
      },
    ],
    name: "DelegateVotesChanged",
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
    inputs: [],
    name: "DOMAIN_SEPARATOR",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
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
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
      {
        internalType: "uint32",
        name: "pos",
        type: "uint32",
      },
    ],
    name: "checkpoints",
    outputs: [
      {
        components: [
          {
            internalType: "uint32",
            name: "fromBlock",
            type: "uint32",
          },
          {
            internalType: "uint224",
            name: "votes",
            type: "uint224",
          },
        ],
        internalType: "struct ERC20Votes.Checkpoint",
        name: "",
        type: "tuple",
      },
    ],
    stateMutability: "view",
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
        name: "delegatee",
        type: "address",
      },
    ],
    name: "delegate",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "delegatee",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "nonce",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "expiry",
        type: "uint256",
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
    name: "delegateBySig",
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
    name: "delegates",
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
    inputs: [],
    name: "getChainId",
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
        name: "blockNumber",
        type: "uint256",
      },
    ],
    name: "getPastTotalSupply",
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
        name: "blockNumber",
        type: "uint256",
      },
    ],
    name: "getPastVotes",
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
    ],
    name: "getVotes",
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
        name: "owner",
        type: "address",
      },
    ],
    name: "nonces",
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
    ],
    name: "numCheckpoints",
    outputs: [
      {
        internalType: "uint32",
        name: "",
        type: "uint32",
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
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "deadline",
        type: "uint256",
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
    name: "permit",
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
];

const _bytecode =
  "0x6101606040527f6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9610140523480156200003757600080fd5b5060405162002266380380620022668339810160408190526200005a91620002b7565b8180604051806040016040528060018152602001603160f81b815250848481600390805190602001906200009092919062000144565b508051620000a690600490602084019062000144565b5050825160208085019190912083518483012060e08290526101008190524660a0818152604080517f8b73c3c69bb8fe3d512ecc4cf759cc79239f7b179b0ffacaa9a75d522b39400f81880181905281830187905260608201869052608082019490945230818401528151808203909301835260c0019052805194019390932091935091906080523060c05261012052506200035e95505050505050565b828054620001529062000321565b90600052602060002090601f016020900481019282620001765760008555620001c1565b82601f106200019157805160ff1916838001178555620001c1565b82800160010185558215620001c1579182015b82811115620001c1578251825591602001919060010190620001a4565b50620001cf929150620001d3565b5090565b5b80821115620001cf5760008155600101620001d4565b634e487b7160e01b600052604160045260246000fd5b600082601f8301126200021257600080fd5b81516001600160401b03808211156200022f576200022f620001ea565b604051601f8301601f19908116603f011681019082821181831017156200025a576200025a620001ea565b816040528381526020925086838588010111156200027757600080fd5b600091505b838210156200029b57858201830151818301840152908201906200027c565b83821115620002ad5760008385830101525b9695505050505050565b60008060408385031215620002cb57600080fd5b82516001600160401b0380821115620002e357600080fd5b620002f18683870162000200565b935060208501519150808211156200030857600080fd5b50620003178582860162000200565b9150509250929050565b600181811c908216806200033657607f821691505b602082108114156200035857634e487b7160e01b600052602260045260246000fd5b50919050565b60805160a05160c05160e051610100516101205161014051611ead620003b96000396000610a0101526000610f4c01526000610f9b01526000610f7601526000610ecf01526000610ef901526000610f230152611ead6000f3fe608060405234801561001057600080fd5b50600436106101a35760003560e01c80636fcfff45116100ee5780639dc29fac11610097578063c3cda52011610071578063c3cda52014610388578063d505accf1461039b578063dd62ed3e146103ae578063f1127ed8146103e757600080fd5b80639dc29fac1461034f578063a457c2d714610362578063a9059cbb1461037557600080fd5b80638e539e8c116100c85780638e539e8c1461032157806395d89b41146103345780639ab24eb01461033c57600080fd5b80636fcfff45146102bd57806370a08231146102e55780637ecebe001461030e57600080fd5b80633644e5151161015057806340c10f191161012a57806340c10f1914610251578063587cde1e146102665780635c19a95c146102aa57600080fd5b80633644e51514610223578063395093511461022b5780633a46b1a81461023e57600080fd5b806323b872dd1161018157806323b872dd146101fb578063313ce5671461020e5780633408e4701461021d57600080fd5b806306fdde03146101a8578063095ea7b3146101c657806318160ddd146101e9575b600080fd5b6101b0610424565b6040516101bd9190611b87565b60405180910390f35b6101d96101d4366004611bf8565b6104b6565b60405190151581526020016101bd565b6002545b6040519081526020016101bd565b6101d9610209366004611c22565b6104cc565b604051601281526020016101bd565b466101ed565b6101ed610597565b6101d9610239366004611bf8565b6105a6565b6101ed61024c366004611bf8565b6105e2565b61026461025f366004611bf8565b61065c565b005b610292610274366004611c5e565b6001600160a01b039081166000908152600660205260409020541690565b6040516001600160a01b0390911681526020016101bd565b6102646102b8366004611c5e565b61066a565b6102d06102cb366004611c5e565b610677565b60405163ffffffff90911681526020016101bd565b6101ed6102f3366004611c5e565b6001600160a01b031660009081526020819052604090205490565b6101ed61031c366004611c5e565b61069f565b6101ed61032f366004611c79565b6106bd565b6101b0610719565b6101ed61034a366004611c5e565b610728565b61026461035d366004611bf8565b6107af565b6101d9610370366004611bf8565b6107b9565b6101d9610383366004611bf8565b61086a565b610264610396366004611ca3565b610877565b6102646103a9366004611cfb565b6109ad565b6101ed6103bc366004611d65565b6001600160a01b03918216600090815260016020908152604080832093909416825291909152205490565b6103fa6103f5366004611d98565b610b11565b60408051825163ffffffff1681526020928301516001600160e01b031692810192909252016101bd565b60606003805461043390611dd8565b80601f016020809104026020016040519081016040528092919081815260200182805461045f90611dd8565b80156104ac5780601f10610481576101008083540402835291602001916104ac565b820191906000526020600020905b81548152906001019060200180831161048f57829003601f168201915b5050505050905090565b60006104c3338484610b95565b50600192915050565b6001600160a01b0383166000908152600160209081526040808320338452909152812054600019811461058157828110156105745760405162461bcd60e51b815260206004820152602860248201527f45524332303a207472616e7366657220616d6f756e742065786365656473206160448201527f6c6c6f77616e636500000000000000000000000000000000000000000000000060648201526084015b60405180910390fd5b6105818533858403610b95565b61058c858585610cb9565b506001949350505050565b60006105a1610ec2565b905090565b3360008181526001602090815260408083206001600160a01b038716845290915281205490916104c39185906105dd908690611e23565b610b95565b60004382106106335760405162461bcd60e51b815260206004820152601f60248201527f4552433230566f7465733a20626c6f636b206e6f7420796574206d696e656400604482015260640161056b565b6001600160a01b03831660009081526007602052604090206106559083610fe9565b9392505050565b61066682826110a6565b5050565b610674338261113d565b50565b6001600160a01b038116600090815260076020526040812054610699906111ce565b92915050565b6001600160a01b038116600090815260056020526040812054610699565b600043821061070e5760405162461bcd60e51b815260206004820152601f60248201527f4552433230566f7465733a20626c6f636b206e6f7420796574206d696e656400604482015260640161056b565b610699600883610fe9565b60606004805461043390611dd8565b6001600160a01b038116600090815260076020526040812054801561079c576001600160a01b038316600090815260076020526040902061076a600183611e3b565b8154811061077a5761077a611e52565b60009182526020909120015464010000000090046001600160e01b031661079f565b60005b6001600160e01b03169392505050565b610666828261124e565b3360009081526001602090815260408083206001600160a01b0386168452909152812054828110156108535760405162461bcd60e51b815260206004820152602560248201527f45524332303a2064656372656173656420616c6c6f77616e63652062656c6f7760448201527f207a65726f000000000000000000000000000000000000000000000000000000606482015260840161056b565b6108603385858403610b95565b5060019392505050565b60006104c3338484610cb9565b834211156108c75760405162461bcd60e51b815260206004820152601d60248201527f4552433230566f7465733a207369676e61747572652065787069726564000000604482015260640161056b565b604080517fe48329057bfd03d55e49b547132e39cffd9c1820ad7b9d4c5307691425d15adf60208201526001600160a01b038816918101919091526060810186905260808101859052600090610941906109399060a00160405160208183030381529060405280519060200120611266565b8585856112b4565b905061094c816112dc565b861461099a5760405162461bcd60e51b815260206004820152601960248201527f4552433230566f7465733a20696e76616c6964206e6f6e636500000000000000604482015260640161056b565b6109a4818861113d565b50505050505050565b834211156109fd5760405162461bcd60e51b815260206004820152601d60248201527f45524332305065726d69743a206578706972656420646561646c696e65000000604482015260640161056b565b60007f0000000000000000000000000000000000000000000000000000000000000000888888610a2c8c6112dc565b6040805160208101969096526001600160a01b0394851690860152929091166060840152608083015260a082015260c0810186905260e0016040516020818303038152906040528051906020012090506000610a8782611266565b90506000610a97828787876112b4565b9050896001600160a01b0316816001600160a01b031614610afa5760405162461bcd60e51b815260206004820152601e60248201527f45524332305065726d69743a20696e76616c6964207369676e61747572650000604482015260640161056b565b610b058a8a8a610b95565b50505050505050505050565b60408051808201909152600080825260208201526001600160a01b0383166000908152600760205260409020805463ffffffff8416908110610b5557610b55611e52565b60009182526020918290206040805180820190915291015463ffffffff8116825264010000000090046001600160e01b0316918101919091529392505050565b6001600160a01b038316610bf75760405162461bcd60e51b8152602060048201526024808201527f45524332303a20617070726f76652066726f6d20746865207a65726f206164646044820152637265737360e01b606482015260840161056b565b6001600160a01b038216610c585760405162461bcd60e51b815260206004820152602260248201527f45524332303a20617070726f766520746f20746865207a65726f206164647265604482015261737360f01b606482015260840161056b565b6001600160a01b0383811660008181526001602090815260408083209487168084529482529182902085905590518481527f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925910160405180910390a3505050565b6001600160a01b038316610d355760405162461bcd60e51b815260206004820152602560248201527f45524332303a207472616e736665722066726f6d20746865207a65726f20616460448201527f6472657373000000000000000000000000000000000000000000000000000000606482015260840161056b565b6001600160a01b038216610d975760405162461bcd60e51b815260206004820152602360248201527f45524332303a207472616e7366657220746f20746865207a65726f206164647260448201526265737360e81b606482015260840161056b565b6001600160a01b03831660009081526020819052604090205481811015610e265760405162461bcd60e51b815260206004820152602660248201527f45524332303a207472616e7366657220616d6f756e742065786365656473206260448201527f616c616e63650000000000000000000000000000000000000000000000000000606482015260840161056b565b6001600160a01b03808516600090815260208190526040808220858503905591851681529081208054849290610e5d908490611e23565b92505081905550826001600160a01b0316846001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef84604051610ea991815260200190565b60405180910390a3610ebc848484611309565b50505050565b6000306001600160a01b037f000000000000000000000000000000000000000000000000000000000000000016148015610f1b57507f000000000000000000000000000000000000000000000000000000000000000046145b15610f4557507f000000000000000000000000000000000000000000000000000000000000000090565b50604080517f00000000000000000000000000000000000000000000000000000000000000006020808301919091527f0000000000000000000000000000000000000000000000000000000000000000828401527f000000000000000000000000000000000000000000000000000000000000000060608301524660808301523060a0808401919091528351808403909101815260c0909201909252805191012090565b8154600090815b8181101561104d576000611004828461133b565b90508486828154811061101957611019611e52565b60009182526020909120015463ffffffff16111561103957809250611047565b611044816001611e23565b91505b50610ff0565b8115611091578461105f600184611e3b565b8154811061106f5761106f611e52565b60009182526020909120015464010000000090046001600160e01b0316611094565b60005b6001600160e01b031695945050505050565b6110b08282611356565b6002546001600160e01b03101561112f5760405162461bcd60e51b815260206004820152603060248201527f4552433230566f7465733a20746f74616c20737570706c79207269736b73206f60448201527f766572666c6f77696e6720766f74657300000000000000000000000000000000606482015260840161056b565b610ebc600861143d83611449565b6001600160a01b038281166000818152600660208181526040808420805485845282862054949093528787167fffffffffffffffffffffffff00000000000000000000000000000000000000008416811790915590519190951694919391928592917f3134e8a2e6d97e929a7e54011ea5485d7d196dd5f0ba4d4ef95803e8e3fc257f9190a4610ebc8284836115c2565b600063ffffffff82111561124a5760405162461bcd60e51b815260206004820152602660248201527f53616665436173743a2076616c756520646f65736e27742066697420696e203360448201527f3220626974730000000000000000000000000000000000000000000000000000606482015260840161056b565b5090565b61125882826116ff565b610ebc600861185483611449565b6000610699611273610ec2565b8360405161190160f01b6020820152602281018390526042810182905260009060620160405160208183030381529060405280519060200120905092915050565b60008060006112c587878787611860565b915091506112d28161194d565b5095945050505050565b6001600160a01b03811660009081526005602052604090208054600181018255905b50919050565b505050565b6001600160a01b03838116600090815260066020526040808220548584168352912054611304929182169116836115c2565b600061134a6002848418611e68565b61065590848416611e23565b6001600160a01b0382166113ac5760405162461bcd60e51b815260206004820152601f60248201527f45524332303a206d696e7420746f20746865207a65726f206164647265737300604482015260640161056b565b80600260008282546113be9190611e23565b90915550506001600160a01b038216600090815260208190526040812080548392906113eb908490611e23565b90915550506040518181526001600160a01b038316906000907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9060200160405180910390a361066660008383611309565b60006106558284611e23565b8254600090819080156114945785611462600183611e3b565b8154811061147257611472611e52565b60009182526020909120015464010000000090046001600160e01b0316611497565b60005b6001600160e01b031692506114b083858763ffffffff16565b91506000811180156114ee575043866114ca600184611e3b565b815481106114da576114da611e52565b60009182526020909120015463ffffffff16145b1561154e576114fc82611b08565b86611508600184611e3b565b8154811061151857611518611e52565b9060005260206000200160000160046101000a8154816001600160e01b0302191690836001600160e01b031602179055506115b9565b856040518060400160405280611563436111ce565b63ffffffff16815260200161157785611b08565b6001600160e01b0390811690915282546001810184556000938452602093849020835194909301519091166401000000000263ffffffff909316929092179101555b50935093915050565b816001600160a01b0316836001600160a01b0316141580156115e45750600081115b15611304576001600160a01b03831615611672576001600160a01b0383166000908152600760205260408120819061161f9061185485611449565b91509150846001600160a01b03167fdec2bacdd2f05b59de34da9b523dff8be42e5e38e818c82fdb0bae774387a7248383604051611667929190918252602082015260400190565b60405180910390a250505b6001600160a01b03821615611304576001600160a01b038216600090815260076020526040812081906116a89061143d85611449565b91509150836001600160a01b03167fdec2bacdd2f05b59de34da9b523dff8be42e5e38e818c82fdb0bae774387a72483836040516116f0929190918252602082015260400190565b60405180910390a25050505050565b6001600160a01b03821661175f5760405162461bcd60e51b815260206004820152602160248201527f45524332303a206275726e2066726f6d20746865207a65726f206164647265736044820152607360f81b606482015260840161056b565b6001600160a01b038216600090815260208190526040902054818110156117d35760405162461bcd60e51b815260206004820152602260248201527f45524332303a206275726e20616d6f756e7420657863656564732062616c616e604482015261636560f01b606482015260840161056b565b6001600160a01b0383166000908152602081905260408120838303905560028054849290611802908490611e3b565b90915550506040518281526000906001600160a01b038516907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9060200160405180910390a361130483600084611309565b60006106558284611e3b565b6000807f7fffffffffffffffffffffffffffffff5d576e7357a4501ddfe92f46681b20a08311156118975750600090506003611944565b8460ff16601b141580156118af57508460ff16601c14155b156118c05750600090506004611944565b6040805160008082526020820180845289905260ff881692820192909252606081018690526080810185905260019060a0016020604051602081039080840390855afa158015611914573d6000803e3d6000fd5b5050604051601f1901519150506001600160a01b03811661193d57600060019250925050611944565b9150600090505b94509492505050565b600081600481111561196157611961611e8a565b141561196a5750565b600181600481111561197e5761197e611e8a565b14156119cc5760405162461bcd60e51b815260206004820152601860248201527f45434453413a20696e76616c6964207369676e61747572650000000000000000604482015260640161056b565b60028160048111156119e0576119e0611e8a565b1415611a2e5760405162461bcd60e51b815260206004820152601f60248201527f45434453413a20696e76616c6964207369676e6174757265206c656e67746800604482015260640161056b565b6003816004811115611a4257611a42611e8a565b1415611a9b5760405162461bcd60e51b815260206004820152602260248201527f45434453413a20696e76616c6964207369676e6174757265202773272076616c604482015261756560f01b606482015260840161056b565b6004816004811115611aaf57611aaf611e8a565b14156106745760405162461bcd60e51b815260206004820152602260248201527f45434453413a20696e76616c6964207369676e6174757265202776272076616c604482015261756560f01b606482015260840161056b565b60006001600160e01b0382111561124a5760405162461bcd60e51b815260206004820152602760248201527f53616665436173743a2076616c756520646f65736e27742066697420696e203260448201527f3234206269747300000000000000000000000000000000000000000000000000606482015260840161056b565b600060208083528351808285015260005b81811015611bb457858101830151858201604001528201611b98565b81811115611bc6576000604083870101525b50601f01601f1916929092016040019392505050565b80356001600160a01b0381168114611bf357600080fd5b919050565b60008060408385031215611c0b57600080fd5b611c1483611bdc565b946020939093013593505050565b600080600060608486031215611c3757600080fd5b611c4084611bdc565b9250611c4e60208501611bdc565b9150604084013590509250925092565b600060208284031215611c7057600080fd5b61065582611bdc565b600060208284031215611c8b57600080fd5b5035919050565b803560ff81168114611bf357600080fd5b60008060008060008060c08789031215611cbc57600080fd5b611cc587611bdc565b95506020870135945060408701359350611ce160608801611c92565b92506080870135915060a087013590509295509295509295565b600080600080600080600060e0888a031215611d1657600080fd5b611d1f88611bdc565b9650611d2d60208901611bdc565b95506040880135945060608801359350611d4960808901611c92565b925060a0880135915060c0880135905092959891949750929550565b60008060408385031215611d7857600080fd5b611d8183611bdc565b9150611d8f60208401611bdc565b90509250929050565b60008060408385031215611dab57600080fd5b611db483611bdc565b9150602083013563ffffffff81168114611dcd57600080fd5b809150509250929050565b600181811c90821680611dec57607f821691505b602082108114156112fe57634e487b7160e01b600052602260045260246000fd5b634e487b7160e01b600052601160045260246000fd5b60008219821115611e3657611e36611e0d565b500190565b600082821015611e4d57611e4d611e0d565b500390565b634e487b7160e01b600052603260045260246000fd5b600082611e8557634e487b7160e01b600052601260045260246000fd5b500490565b634e487b7160e01b600052602160045260246000fdfea164736f6c6343000809000a";

type ERC20VotesMockConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ERC20VotesMockConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ERC20VotesMock__factory extends ContractFactory {
  constructor(...args: ERC20VotesMockConstructorParams) {
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
  ): Promise<ERC20VotesMock> {
    return super.deploy(
      name,
      symbol,
      overrides || {}
    ) as Promise<ERC20VotesMock>;
  }
  getDeployTransaction(
    name: string,
    symbol: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(name, symbol, overrides || {});
  }
  attach(address: string): ERC20VotesMock {
    return super.attach(address) as ERC20VotesMock;
  }
  connect(signer: Signer): ERC20VotesMock__factory {
    return super.connect(signer) as ERC20VotesMock__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ERC20VotesMockInterface {
    return new utils.Interface(_abi) as ERC20VotesMockInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ERC20VotesMock {
    return new Contract(address, _abi, signerOrProvider) as ERC20VotesMock;
  }
}
