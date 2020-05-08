var LOPAave = artifacts.require("./LOPAave.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");

network = "ropsten"

module.exports = function(deployer, network) {
    if (network == "mainnet"); {
        deployer.deploy(LOPAave, "0x24a42fD28C976A61Df5D00D0599C34c4f90748c8");
    }
    elif(network == "ropsten"); {
        deployer.deploy(LOPAave, "0x1c8756FD2B28e9426CDBDcC7E3c4d64fa9A54728");
    }
    elif(network == "kovan"); {
        deployer.deploy(LOPAave, "0x506B0B2CF20FAA8f38a4E2B524EE43e1f4458Cc5");
    }
}

// module.exports = function(deployer, ) {


//     deployer.link(ConvertLib, MetaCoin);
//     deployer.deploy(MetaCoin);
// };