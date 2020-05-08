
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

---
## IMPLEMENTATION

#### Tokens equivalent to pools: 

Similar to aTokens, Uniswap pool shares, ctokens, balancer pool shares... we'll provide users with LOPtokens that correspond to shares in one of these 4 Investment Vehicles (IV). IV are instances of [LOPPool.sol](https://github.com/cyril-attie/league-of-pools/blob/angular-truffle-box/contracts/LOPPool.sol) that inherits from ERC20 standard and contains the code to interact with the IV. [LOPFactory.sol](https://github.com/cyril-attie/league-of-pools/blob/angular-truffle-box/contracts/LOPFactory.sol) contains the code to summon and register new IV, and ensure there are no duplicates. 

On player deposits, [LOPPool.sol](https://github.com/cyril-attie/league-of-pools/blob/angular-truffle-box/contracts/LOPPool.sol) mints an amount of token shares proportional to the amount brought to the IV fund: 

    newly_minted_shares / outstanding_shares_before_deposit = deposit / IV_funds_before_deposit

As the IV fund increases in value thanks to LP (liquidity pool) fees and lending interest, the IV tokens will increase in value. 

#### Top Pooler of the League: 

Upon summoning a hero, players are given a NFToken (ERC721 compliant) used to store the hero information. The Players' heroes are initialized with 20 force points of defense. Force points can be earned and assigned to attack or defense. Points can be earned in the following ways: 
1. Challenge another player to steal a number of points defined by a formula according to the attackant attack points, the attacked defense point and a random variable. Cooldown 24h. 
2. Players can call a function to claim points according to the profit accrued in pools (formula TBD). Cooldown 72h.
3. Every week, players clan claim pòints proportional to the amount of profit accrued **any** player of the clan has earned. 

Rationale: in order of priority 1. Reward playing, 2. Reward investing, 3. Reward social interaction/network effect.

Once a month the player that earned the most points during the month will receive a LOP governance token. 

The clan that earned the most points (as a whole) receive a LOP governance token split among the members of the clan.

#### LOP Governance token

The LOP governance token allows to propose and vote on new features by using the Compound governance model. 

On burning on any LOPPool token, LOP governance token earns a 0.25% fee. This fee can be lowered to zero the first year. 

#### The battle Reward

Heroes start with 20 defense points. 
On claiming points players choose either attack or defense points. Attack points are the only ones that count for the monthly league. 

Defense points reduce the points drained by others on attacks. The formula defining the points drained is:
      
    example: drained_points = max( (attacker_attack_points - attacked_defense_points) * random(0,1) , 1);
    
Rationale, at the beginning people will earn 1 points at a time attack until having a enough attack points and then will start attacking noobs or keep attacking the top of the table. That way people we'll have to choose between either attacking a weaker and steal more points, or attacking a stronger and level things out as the highest ranking heroes can only attack once. 

#### Every Day Reward

If they haven't claimed in the last 24h, players can claim 1 additional point by challenging any other player. 

#### Interest Reward

Players can call a function to claim points according to the profit accrued in pools. Cooldown 72h.
 
4. Every week, players that are in a "PoolTogether" clan can earn pòints proportional to the amount of profit accrued **any** player of the clan has earned. 


---

example: 300 LOP_UNISWAP_WETH_DAI == Uniswap pool. On new desposit x, the user get x/Up newly minted units of LOP_UNISWAP_WETH_DAI where x is the deposit and Up is the Uniswap pool value. On redemption of x LOPs_Uniswap the user gets x/(total outstanding LOPs_Uniswap)*Up where Up is the uniswap pool value. 

When burning the tokens we take a small fee that goes to the LOP ERC20 address and that's a governance token. 

# UX

The user appears in a 2D world where there are castles

# TODO

create storage contract
extract storage info from thegraph by passing the public address
list all users with their liquidity pool profiles including castle value and soldiers //ALLOWS TO LIST CASTLES 
see how much liquidity profile thorugh the graph
users can refresh their profile once a day 
soldiers can attack only once per day
add reentrancy guard see contracts/utils/address.sol



1. Front call LOP.sol contract to query users addresses, current_deposit_value and refresh_timestamp
2. Front calls the Graph to query user info on liquidity pools for 10~20 users to be displayed
3. Front renderize 

## CLIENT REFRESH

Users can log in once a day to refresh their stats, when the click on 'refresh', two things happen:

11. USER STATS: After the Net Asset Value of the underlying LOP shares we subtract the sum of the current deposit value and the points earned. If the result is positive the user can claim some points.  

2. CLOSE LOOSING POSITIONS: The client will call a view function looping over all players and over all positions for each player and return a list of positions to be liquidated. Another functionn will close positions for each of the accounts in the list.


# proposals

call it League Of Poolers. rationale: player-centered name
next steps: be able to create sets of pools from set protocol
Referral is 20 defense points
With all the collateral deposited borrow up till 10% and deposit it elsewhere (TBD by governance), reward goes to LOP governance token holders

mapping (string => addresses) poolTypeToLibrary; 

ILOPpoolTypeToLibrary