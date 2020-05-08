pragma solidity >=0.4.21 <0.7.0;

import "contracts/LOPPoolTemplates/aave/AavePool.sol";
import "contracts/interfaces/IPoolProviderFactory.sol";
import "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract aavePoolFactory is IPoolProviderFactory {
    //@dev IPoolProviderFactory implementation
    //@notice to add more pools from Aave
    function createPool(address underlyingAsset) external returns (address newPool) {

        ERC20 underlying = IERC20(underlyingAsset);
        string name = abi.encodePacked("LOP_",underlying.name(),"_AAVE");
        string symbol = abi.encodePacked("LOP_",underlying.symbol(),"_AAVE");
        newPool = new AavePool( underlyingAsset, name, symbol );
    }
}
