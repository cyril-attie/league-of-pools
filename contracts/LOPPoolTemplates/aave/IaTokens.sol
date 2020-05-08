pragma solidity ^0.6.4;

import "node_modules/@openzeppelin/contracts/token/ERC20";
import "node_modules/@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

/**
 * @title Aave ERC20 AToken interface
 *
 * @dev 
 * @author Aave
 */
interface AToken is ERC20, ERC20Detailed {
    event Redeem(
        address indexed _from,
        uint256 _value,
        uint256 _fromBalanceIncrease,
        uint256 _fromIndex
    );
    event MintOnDeposit(
        address indexed _from,
        uint256 _value,
        uint256 _fromBalanceIncrease,
        uint256 _fromIndex
    );
    event BurnOnLiquidation(
        address indexed _from,
        uint256 _value,
        uint256 _fromBalanceIncrease,
        uint256 _fromIndex
    );
    event BalanceTransfer(
        address indexed _from,
        address indexed _to,
        uint256 _value,
        uint256 _fromBalanceIncrease,
        uint256 _toBalanceIncrease,
        uint256 _fromIndex,
        uint256 _toIndex
    );
    event InterestStreamRedirected(
        address indexed _from,
        address indexed _to,
        uint256 _redirectedBalance,
        uint256 _fromBalanceIncrease,
        uint256 _fromIndex
    );
    event RedirectedBalanceUpdated(
        address indexed _targetAddress,
        uint256 _targetBalanceIncrease,
        uint256 _targetIndex,
        uint256 _redirectedBalanceAdded,
        uint256 _redirectedBalanceRemoved
    );
    event InterestRedirectionAllowanceChanged(
        address indexed _from,
        address indexed _to
    );

    function _transfer(address _from, address _to, uint256 _amount) internal;
    function redirectInterestStream(address _to) external;
    function redirectInterestStreamOf(address _from, address _to) external;
    function allowInterestRedirectionTo(address _to) external;
    function redeem(uint256 _amount) external;    
    function mintOnDeposit(address _account, uint256 _amount) external;   
    function isTransferAllowed(address _user, uint256 _amount) public view returns (bool);   
    function getUserIndex(address _user) external view returns(uint256);
    function getInterestRedirectionAddress(address _user) external view returns(address);
    function getRedirectedBalance(address _user) external view returns(uint256);
    function cumulateBalanceInternal(address _user)
        internal
        returns(uint256, uint256, uint256, uint256);
    function updateRedirectedBalanceOfRedirectionAddressInternal(
        address _user,
        uint256 _balanceToAdd,
        uint256 _balanceToRemove
    ) internal;
    function calculateCumulatedBalanceInternal(
        address _user,
        uint256 _balance
    ) internal view returns (uint256);
    function executeTransferInternal(
        address _from,
        address _to,
        uint256 _value
    ) internal;
    function redirectInterestStreamInternal(
        address _from,
        address _to
    ) internal;   
    function resetDataOnZeroBalanceInternal(address _user) internal returns(bool);
}