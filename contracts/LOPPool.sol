pragma solidity >=0.4.21 < 0.7.0;

import "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "contracts/interfaces/ILOPPool.sol";


//@notice pool contracts is ERC20, example aave_Dai, uniswapv2_WETH_DAI, compound_Dai, balancer_multicoin...

contract LOPPool is ILOPPool, ERC20 {

    address public underlyingAddress;
    address public underlyingAcceptedCurrency;
    //@notice minimum deposit is set to $1 (DAI)
    uint256 MINIMUM_DEPOSIT = 1**18;

    event DepositCompleted(address _from, uint256 amount);
    event withdrawalCompleted(address _to, uint256 amount);
    constructor (uint256 poolType, string memory name, string memory symbol) ERC20(name, symbol) {
        factory = msg.sender;
    }

    // called once by the factory at time of deployment
    function initialize(address _underlyingAddress, address _underlyingAcceptedCurrency) external {
        require(_msgSender() == factory, 'League Of Pools: FORBIDDEN'); // sufficient check
        underlyingAddress = _underlyingAddress;
        underlyingAcceptedCurrency = _underlyingAcceptedCurrency;
    }

}
