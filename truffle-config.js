require('dotenv').config();
const PrivateKeyProvider = require("truffle-privatekey-provider");

module.exports = {
  networks: {

    development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 7545,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
    },

    ropsten: {
      provider: () => new PrivateKeyProvider (
        process.env.PKEY,
        process.env.ROPSTEN_URL),
      network_id: 3,
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  },

  plugins: [
    "solidity-coverage",
    "truffle-flatten"
  ],

  // Set default mocha options here, use special reporters etc.
  mocha: {
    reporter: 'eth-gas-reporter',
    reporterOptions : { 
      excludeContracts: ['Migrations'] 
    }
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.6", 
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },

  db: {
    enabled: false
  }
};
