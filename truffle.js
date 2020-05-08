require('dotenv').config();
const Web3 = require("web3");
const HDWallet = require("truffle-hdwallet-provider");
// const Wallet = require('ethereumjs-wallet');

const mnemonic = process.env.MNEMONIC;
const infuraKey = process.env.INFURA_API_KEY;

module.exports = {
    networks: {
        development: {
            host: "localhost",
            port: 8545,
            network_id: "*" // Match any network id
        },

        ropsten: {
            provider: () => new HDWalletProvider(mnemonic, `https://ropsten.infura.io/v3/${infuraKey}`),
            network_id: 3 // Ropsten's id
        },
        kovan: {
            provider: () => new HDWalletProvider(mnemonic, `https://kovan.infura.io/v3/${infuraKey}`),
            network_id: 42

        }
    }
};