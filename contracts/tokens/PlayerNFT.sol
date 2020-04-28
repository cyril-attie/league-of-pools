pragma solidity ^0.5.0;

import "./ERC721/ERC721.sol";


/**
 * @title Player account Non-Fungible Token 
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract PlayerNFT is ERC721 {

    enum Houses { Gryffindor, Slytherin, Ravenclaw, Hufflepuff } //to be replaced by creature types

    Struct User is 
    IERC721,
    SupportsInterface{
    Houses type;
    uint256 initial_deposit_value; //in base currency DAI
    uint256 initial_deposit_timestamp; 
    uint256 current_deposit_value; //in DAI using oracle prices
    uint256 current_deposit_timestamp;
    //attack and armor are increased in refresh_deposit_value()   
    uint256 attack_points;       
    uint256 armor_points;
    }
    //@notice could 
    mapping (address => User) public users;
    mapping (address => uint32) public userPool; 

    //@notice by default increase attack points
    function increase_points( bool attack ) {
        require(users[msg.sender].current_deposit_timestamp<block.timestamp+86400, "Cooldown period has not finished!");

    }

    //@notice called when the user wants to cash new interest for points
    function _refresh_deposit_value(address playerId) private returns (bool) {
        
    }


    function current_deposit_timestamp() view returns (uint256) {
        require(users[msg.sender].initial_deposit_timestamp!=0, "This addres has not a player account linked to it.")
        return users[msg.sender].current_deposit_timestamp;
    }

    
}