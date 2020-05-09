pragma solidity ^6.0.0;

import "contracts/ILOPPool.sol";
import "node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract LOPPoolFactory is Ownable {

    address[] public allPools;
    mapping (address => bytes32);
    bytes32[] public poolProviders;
    mapping(bytes32 => bool) public poolProviderIsActive; //pool providers like aave, compound... uniswap, balancer
    mapping(bytes32 => address) public templateAddressFor; 
    mapping(bytes32 => mapping(address => address)) public getPool; //provider.underlyingAddress

    event PoolCreated(
        address indexed underlyingAddress,
        address Pool,
        uint256 allPools
    );

    event ProviderCreated(
        bytes32 providerName,
        address providerTemplateAddress
    );

    //@dev should this function should only be called from the governance cause we cannot
    function createPoolProviderTemplate(
        bytes32 _poolProvider,
        address _poolTemplate
    ) external onlyOwner {
        require(_poolTemplate != address(0), "League Of Pools: ZERO_ADDRESS");
        require(
            templateAddressFor[_poolProvider] == address(0),
            "League Of Pools: TEMPLATE_EXISTS"
        );
        templateAddressFor[_poolProvider] = _poolTemplate;
    }

    function createPool(
        bytes32 _poolProvider,
        address _underlyingAddress,
        address _underlyingAcceptedCurrency 
    ) external onlyOwner returns (address pool) {
        require(
            _underlyingAddress != address(0),
            "League Of Pools: ZERO_ADDRESS"
        );
        require(
            getPool[_poolProvider][_underlyingAddress] == address(0),
            "League Of Pools: POOL_EXISTS");
        // single check is sufficient
        // bytes memory bytecode = type(LOPPool).creationCode;
        // bytes32 salt = keccak256(abi.encodePacked(poolProvider,underlyingAddress));
        // assembly {
        //     pool := create2(0, add(bytecode, 32), mload(bytecode), salt)
        // }
        address pool = ILOPPoolProviderFactory(getPool[_poolProvider]).createPool(
            _underlyingAcceptedCurrency
        );
        getPool[_poolProvider][_underlyingAcceptedCurrency] = pool;
        allPools.push(pool);
        emit PoolCreated(_underlyingAddress, pool, allPools.length);
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == owner, "League Of Pools: FORBIDDEN");
        feeTo = _feeTo;
    }
}
