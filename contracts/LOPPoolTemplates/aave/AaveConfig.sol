pragma solidity >=0.4.21 < 0.7.0;

contract AaveConfig {
    //@dev to be looked up from aave pool contract
    uint16 public aaveReferralCode;
    uint256 public MINIMUM_DEPOSIT = 5000000000;
    address public aaveAddressProvider;

    function setAaveReferralCode(uint16 _ref) {
        aaveReferralCode = _ref;
    }
    function setAaveAddressProvider(address _addr) {
        aaveAddressProvider = _addr 
    }
    function setMinimumDeposit(uint256 _amount) {
        MINIMUM_DEPOSIT = _amount;
    }
}