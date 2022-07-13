

## Debond-APM.
### About: 

This module consist of smart contract for Automated Pair Maker, which acts as the single consolidated pool for ERC20 tokens represented by bonds whenever they are issued / redeemed. It manages the liquidity of the  different bond pairs internally (called as virtual liquidity pool) rather than issuing seperate contracts each time the LP is created.

The addition/removal of the liquidity of the pool (done via bank ),after they are issued the bond defining the transaction. Along with that it also allows swaps between the different virtual pool pairs between the bond,nonce classes being validated (as purchaseable) by the banks.


##  contract description: 

[APM.sol](./contracts/APM.sol) consist of the following storage mapping:

```solidity
    mapping(address => uint256) internal totalReserve; // mapping of (Bond Tokenised Address => supply of token overall ).
    mapping(address => uint256) internal totalVlp; (mapping of the total volume of liquidity pair)
    mapping(address => mapping( address => uint) ) vlp; // mapping of the token address => bond address => value.
```


## Development workflow: 
1. Bank contract calls the APMRouter.swapExactTokensWithTokens or  function to either mint the  .

2. then internally it calls the  `APM.updateWhenAddLiquidityOneToken() / updateLiquidity()` (based on the type of bond added) function that checks whether there is LP available there, if not it initializes the pair and then updates the liquidity of the virtual pair as well as the whole pool.

3. Similarly during the redemption of the bond: the  UI  interacts with the Bank.redeem..with..() to redeem the bonds (via burning) along with internally calling the `updateWhenRemoveLiquidityOneToken() / updateliquidity()` function that will be updating the overall liquidity along with the VLP.

### Security consideration.
**NOTE: Anyone can put the liquidity in the APM without going through the traditional process of issuing bonds on the bank, its MUST NOT be followed as you will LOOSE THE FUNDS as there are no  methods to remove liquidity unless users via   banks have to redeem the bond corresponding to liquidity **


## reports: 
1.[markdown report for functions](./docs/APM_report.md).
2.[dependency graph](./docs/APM.png).
3.[APM functioning graph](./docs/APM-graph.png)

### deployment steps : 
1. add private key info in the .env file (having permissions of the governance) and the settings of RPC provider for the deployment.

2. Insure that test are passing, then deploy the APM as following:
```bash
> truffle deploy deploy/3_deploy_contract.js.
```
3. then set the corresponding address of dependency `APMRouter`,  `Bank`, `Bond` and `Governance` address (either using etherscan or writing the scripts). 


