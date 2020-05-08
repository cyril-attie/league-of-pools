pragma solidity >=0.4.21 <0.7.0;

import "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

//@title LOP pool interface
interface ILOPPool {
//@dev the factory contract address and initialization function of the pool
    function factory() external view returns (address);
    function initialize(address, address) external;
//---------------------------------------------------------
//@dev Mint and burn interface through deposit() and withdraw() to the pool
    event DepositReceived(address _from, uint256 amount);
    event withdrawalCompleted(address _to, uint256 amount);

    //@dev returns the total value of the underlying pool holdings in Dai
    function _totalPoolHoldings() external view returns (uint256 _fundValue);

    //@notice deposit underlying in the pool
    function deposit(uint256 amount) external payable;

    //@notice redeem pool token for underlying
    function redeem(address _to, uint256 amount) external;
//---------------------------------------------------------
    //@dev ERC20
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
}