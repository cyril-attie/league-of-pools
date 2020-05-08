pragma solidity >=0.4.21 <0.7.0;

// Import interface for ERC20 standard
import "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "node_modules/@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "contracts/interfaces/ILOPPool.sol";
import "contracts/LOPPoolTemplates/aave/ILendingPoolAddressesProvider.sol";
import "contracts/LOPPoolTemplates/aave/ILendingPool.sol";
import "contracts/LOPPoolTemplates/aave/IaTokens.sol";

//@title Aave pool template
//@TODO refactor to put as much code as possible in aaveConfig
contract LOPAave is ILOPPool, ERC20 {
    using SafeERC20 for ERC20;

    address public underlyingAsset;

    LendingPoolAddressesProvider public provider;
    LendingPool public aavePool;
    AaveConfig public aaveConfig;

    event DepositCompleted(address _from, uint256 amount);
    event withdrawalCompleted(address _to, uint256 amount);

    constructor(
        address memory _underlyingAcceptedCurrency,
        string memory _name,
        string memory _symbol
    ) public ERC20(_name, _symbol) {
        aaveConfig = AaveConfig(configAddress);
        provider = LendingPoolAddressesProvider(
            aaveConfig.aaveAddressProvider()
        );
        aavePool = LendingPool(provider.getLendingPool());
        underlyingAsset = _underlyingAsset;
    }

    //@notice update the aave lending pool
    //@dev called from the front only if addresses don't match
    modifier checkPoolAddress {
        if (aavePool != LendingPool(provider.getLendingPool())) {
            aavePool = LendingPool(provider.getLendingPool());
        }
        _;
    }

    //@dev returns the pool balance of aTokens in the reserve
    function totalPoolHoldings() public view returns (uint256 poolBalance) {
        (poolBalance, , , , , , , , , , ) = LendingPool.getUserReserveData(
            underlyingAddress,
            address(this)
        );
    }

    //@notice deposit in the IV pool
    //@param _amount is the amount of underlying reserve token to be deposited
    function deposit(uint256 _amount) external payable checkPoolAddress {
        require(
            _amount >= MINIMUM_DEPOSIT,
            "Deposit must be at least one dollar"
        );
        ERC20(underlyingAsset).safeTransferFrom(
            _msgSender(),
            address(this),
            _amount
        ); //transfer user funds to this contract
        before = totalPoolHoldings(_reserve);
        aavePool.deposit(
            underlyingAsset,
            _amount,
            aaveConfig.aaveReferralCode()
        ); //if deposit fails transaction reverts
        // after= totalPoolHoldings(_reserve);
        // require(before+_amount==after);
        uint256 memory poolHoldings = totalPoolHoldings();
        uint256 memory minted = poolHoldings == 0
            ? _amount
            : (_amount * totalSupply) / poolHoldings;
        _mint(_msgSender(), minted); //_amount/totalpoolholdings == minted/totalsupply
        emit DepositCompleted(_msgSender(), _amount);
    }

    //@notice withdraw from the pool
    //@dev after Burning transfer the underlyingAcceptedCurrency amount to _to
    //@param _amount is the amount of LOP tokens to be redeemed
    //@param underlyingAddress of the aToken
    function withdraw(uint256 _amount) external {
        amount = (_amount > balanceOf[_msgSender()])
            ? balanceOf[_msgSender()]
            : _amount;
        _burn(_msgSender(), _amount);
        //@TODO get the aTokenAddress from somewhere
        uint256 underlyingAmount = _amount * _totalPoolHoldings() / _totalSupply;
        IaToken(aTokenAddress[underlyingAsset]).redeem(underlyingAmount);
        IERC20(underlyingAsset).transfer(_msgSender(), underlyingAmount);
        emit WithdrawalCompleted(_msgSender(), _amount);
    }
}
