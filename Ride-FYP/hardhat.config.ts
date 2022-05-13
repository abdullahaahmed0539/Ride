// import "@nomiclabs/hardhat-waffle";
// import "@typechain/hardhat";
// import "hardhat-gas-reporter";
// import "@nomiclabs/hardhat-etherscan";
// import "solidity-coverage";

// import "./tasks/accounts";
// import "./tasks/deploy";

// import { resolve } from "path";

// import { config as dotenvConfig } from "dotenv";
// import { HardhatUserConfig } from "hardhat/config";
// import { NetworkUserConfig } from "hardhat/types";
// // require("@nomiclabs/hardhat-ethers");
// // require("@nomiclabs/hardhat-etherscan");

// dotenvConfig({ path: resolve(__dirname, "./.env") });

// const chainIds = {
//   goerli: 5,
//   hardhat: 31337,
//   kovan: 42,
//   mainnet: 1,
//   rinkeby: 4,
//   ropsten: 3,
//   // polygon: 45,
//   matic: 80001,
// };

// // Ensure that we have all the environment variables we need.
// const mnemonic: string | undefined = process.env.MNEMONIC;
// if (!mnemonic) {
//   throw new Error("Please set your MNEMONIC in a .env file");
// }

// const privateKey: string | undefined = process.env.PRIVATE_KEY;
// if (!privateKey) {
//   throw new Error("Please set your PRIVATE_KEY in a .env file");
// }

// const infuraApiKey: string | undefined = process.env.INFURA_API_KEY;
// if (!infuraApiKey) {
//   throw new Error("Please set your INFURA_API_KEY in a .env file");
// }

// const polygonApiKey: string | undefined = process.env.POLYGONSCAN_API_KEY;
// if (!polygonApiKey) {
//   throw new Error("Please set your POLYGONSCAN_API_KEY in a .env file");
// }

// function getChainConfig(network: keyof typeof chainIds): NetworkUserConfig {
//   const url: string = "https://" + network + ".infura.io/v3/" + infuraApiKey;
//   return {
//     accounts: {
//       count: 10,
//       mnemonic,
//       path: "m/44'/60'/0'/0",
//     },
//     chainId: chainIds[network],
//     url,
//   };
// }

// const config: HardhatUserConfig = {
//   defaultNetwork: "hardhat",
//   gasReporter: {
//     currency: "USD",
//     enabled: process.env.REPORT_GAS ? true : false,
//     excludeContracts: [],
//     src: "./contracts",
//   },
//   networks: {
//     hardhat: {
//       accounts: {
//         mnemonic,
//       },
//       chainId: chainIds.hardhat,
//     },
//     goerli: getChainConfig("goerli"),
//     kovan: getChainConfig("kovan"),
//     rinkeby: getChainConfig("rinkeby"),
//     ropsten: getChainConfig("ropsten"),
//     matic: {
//       url: "https://rpc-mumbai.maticvigil.com",
//       accounts: [privateKey]
//     }
//   },
//   etherscan: {
//     apiKey: VA4TUUDSFJSAHBYPYX8WC2Z5VUE7YPZUPR
//   },
//   paths: {
//     artifacts: "./artifacts",
//     cache: "./cache",
//     sources: "./contracts",
//     tests: "./test",
//   },
//   solidity: {
//     compilers: [
//       {
//         version: "0.8.0",
//         settings: {
//           metadata: {
//             // Not including the metadata hash
//             // https://github.com/paulrberg/solidity-template/issues/31
//             bytecodeHash: "none",
//           },
//           // Disable the optimizer when debugging
//           // https://hardhat.org/hardhat-network/#solidity-optimizer-support
//           optimizer: {
//             enabled: true,
//             runs: 800,
//           },
//         },
//       },
//       {
//         version: "0.8.9",
//         settings: {
//           metadata: {
//             // Not including the metadata hash
//             // https://github.com/paulrberg/solidity-template/issues/31
//             bytecodeHash: "none",
//           },
//           // Disable the optimizer when debugging
//           // https://hardhat.org/hardhat-network/#solidity-optimizer-support
//           optimizer: {
//             enabled: true,
//             runs: 800,
//           },
//         },
//       },
//     ],
//   },
//   // typechain: {
//   //   outDir: "src/types",
//   //   target: "ethers-v5",
//   // },
// };

// export default config;

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  defaultNetwork: "matic",
  networks: {
    hardhat: {
    },
    matic: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: process.env.POLYGONSCAN_API_KEY
  },
  solidity: {
    compilers: [
      {
        version: "0.8.0",
        settings: {
          metadata: {
            // Not including the metadata hash
            // https://github.com/paulrberg/solidity-template/issues/31
            bytecodeHash: "none",
          },
          // Disable the optimizer when debugging
          // https://hardhat.org/hardhat-network/#solidity-optimizer-support
          optimizer: {
            enabled: true,
            runs: 800,
          },
        },
      },
      {
        version: "0.8.9",
        settings: {
          metadata: {
            // Not including the metadata hash
            // https://github.com/paulrberg/solidity-template/issues/31
            bytecodeHash: "none",
          },
          // Disable the optimizer when debugging
          // https://hardhat.org/hardhat-network/#solidity-optimizer-support
          optimizer: {
            enabled: true,
            runs: 800,
          },
        },
      },
    ],
  },
  // solidity: {
  //   version: "0.8.0",
  //   settings: {
  //     optimizer: {
  //       enabled: true,
  //       runs: 200
  //     }
  //   }
  // },
}