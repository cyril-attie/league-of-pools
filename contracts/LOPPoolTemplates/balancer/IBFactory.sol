pragma solidity >=0.4.21 <0.7.0;

//interface to https://github.com/balancer-labs/balancer-core/blob/master/contracts/BFactory.sol
// Builds new BPools, logging their addresses and providing `isBPool(address) -> (bool)`

interface IBFactory {
    event LOG_NEW_POOL(
        address indexed caller,
        address indexed pool
    );

    event LOG_BLABS(
        address indexed caller,
        address indexed blabs
    );

    function isBPool(address b)
        external view returns (bool);

    function newBPool()
        external
        returns (BPool);
}
