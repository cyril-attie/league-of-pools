# league-of-pools
DeFi game to place money in liquidity pools and play with the interest by defying each other

Anyone can invest in Ethereum DeFi pools and other cryptos through a gaming interface. 

Moreover they play with the profits made in the game by defying each other.

# INVESTING:

New players put money in League of Pools, and get a character. With the money they can invest in Aave, Balancer, Compound and Uniswap liquidity pools making profits. As well they can adventure in pTokens which are like foreign currencies.

## LIQUIDITY POOLS: 

- Users can see a list of ERC20 pairs. 
- At first the user won´t know what is the best liquidity pool.
- As they play investing in different pairs, they will get stats on which returned the best profits.
- Moreover they can 'spy' other characters to see their investment stats and get inspiration :-)

# PROFIT: DEFENSE OR SOLDIER?

In the UI, user initial deposit is represented by their character´s life points. They can use that profit as an armor or attack points. Therefore each user's total money would be the sum of life+armor+attack, where armor and attack represent the profit.

If he gets a armor points, his character gets bigger because it represents more money. Also, he has greater odds to win when he gets attacked.

If he gets a attack points, he can attack once per day. He chooses the number of attack points to attack with, and can only attack characters with same attack strenght.

By default the attackant user wins a randon percentage of the victims attack points (and the money they represent), and if he loses everything remains the same.
If the victim has armor points, instead of losing the full amount of attack points, he loses 50% of defensive points.


## IMPLEMENTATION

**2 options**
1. The user deposits in our contract he gets some tokens that represent his balance of a particular item in which our contract is invested. (risky)

2. Intermediary contract that piggybacks a low fee wtihdrawing the money from the game. 

3. Our contract is just a relayer that channels the user investment towards the DeFi platforms and contains a handful of view functions calls to DeFi contracts. (simple)

Add an option to put earned interest individually in pool together.

# UX

The user appears in a 2D world where there are castles

# TODO
create storage contract
extract info from thegraph by passing a public address
list all users with their liquidity pool profiles including castle value and soldiers //ALLOWS TO LIST CASTLES 
see how much liquidity profile thorugh the graph
users can refresh their profile once a day 
soldiers can attack only once per day


1. Front call LOP.sol contract to query users addresses, current_deposit_value and refresh_timestamp
2. Front calls the Graph to query user info on liquidity pools for 10~20 users to be displayed
3. Front renderize 



let defense_style = default_defense_style ? default_defense_style : 0; 

user {
    address 
    tipo 'pepito'
    initial_deposit
    initial_timestamp
    refresh_deposit_value
    refresh_timestamp
    attack_points     //one soldier represents one wei 
    armor_points
    pool_together_points
    pool_together_points_clan
    defense_style : a (not visible)
}
