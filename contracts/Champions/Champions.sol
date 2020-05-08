pragma solidity ^0.5.0;

import "../../node_modules/@openzeppelin/token/ERC721/ERC721.sol";


/**
 * @title Player account Non-Fungible Token
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ChampionBattefield is ERC721("League of Pools Champions", "LOPC") {
    //@notice months since the beginning, every month is a new league
    uint32 epoch;
    

    //@dev the champion object
    struct Champion {
        string champioName;
        uint256 referrerId;
        uint256 attackPoints;
        uint256 defensePoints;
        uint256 clan;
        uint64 cooldownTimestamp;
    }

    //@notice ERC721 tokenIds to champions
    mapping(uint256 => Champion) _tokenIdTochampions;

    //@notice Champion has been created
    event ChampionCreated(
        uint64 indexed epoch,
        uint256 indexed championId,
        uint256 indexed championName
    );

    //@notice Points have been stolen from one champion to another
    event StolenPoints(
        uint64 indexed epoch,
        uint256 indexed attackerId,
        uint256 indexed victimId,
        uint256 indexed stolenPoints
    );

    //@notice A referral has been completed by summoning a noob champion
    event SocialReferralCompleted(
        uint64 indexed epoch
        uint256 indexed referrerId,
        uint256 indexed noobId,
        uint256 indexed newPoints
    );

    //@notice Points have been increased from interest
    event InterestEarnedPoints(
        uint64 indexed epoch,
        uint256 indexed championId,
        uint256 indexed newPoints,
        uint256 indexed poolId
    );

    //@notice Summon a champion without referral code
    //@dev this function can be called from the deposit() function in LOPPool
    function _summonNewChampion(address _to, string _championName) internal {
        _summonNewChampion(_to, _championName, 0);
    }

    //@notice Summon a champion with a referral code
    //@dev this function can be called from the deposit() function in LOPPool
    function _summonNewChampion(
        address _to,
        string _champoinName,
        uint256 refferalId
    ) internal {
        emit ChampionCreated(epoch, championId, championName);
        emit SocialReferralCompleted(epoch, referrerId, noobId, newPoints);
    }

    //@notice attack another champion
    //@dev external, only summoner can send champion to attack, only after champion cooldown
    function attack(uint256 _attackerId, uint256 _victimId) external {
        require(
            _tokenOwners[_attackerId] == _msgSender(),
            "You must be the summoner to send the champion to war!"
        );
        require(champions[AttackerId].cooldownTimestamp < block.timestamp);

        emit StolenPoints(epoch, attackerId, victimId, stolenPoints);
    }

    //@notice called when the user wants to cash new interest for points
    function _increasePointsFromInterest(address playerId)
        private
        returns (bool)
    {
        emit InterestEarnedPoints(epoch, championId, newPoints, poolId);
    }
}
