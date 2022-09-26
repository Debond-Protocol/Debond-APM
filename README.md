## Debond-APM.
### About: 

This module consist of smart contract for Automated Pair Maker, which acts as the single consolidated pool for ERC20 tokens represented by bonds whenever they are issued/ redeemed. It manages the liquidity of the  different bond pairs internally (called as virtual liquidity pool) rather than issuing separate contracts each time the LP is created.

The addition/removal of the liquidity of the pool (done via bank),after they are issued the bond defining the transaction. Along with that it also allows swaps between the different virtual pool pairs between the bond,nonce classes being validated (as purchaseable) by the banks.

### uses:

- Bond issuer contract (ie bank) who want to submit the liquidity to the APM and then issue the bond.

- governance contract that wants to transfer the unlocked supply to the whitelisted address (allocatedToken).


##  contract description: 

[APM.sol](./contracts/APM.sol) consist of the following storage mapping:

```solidity
    mapping(address => uint256) internal totalReserve; // mapping of (Bond Tokenised Address => supply of token overall ).
    mapping(address => uint256) internal totalVlp; (mapping of the total volume of liquidity pair)
    mapping(address => mapping( address => uint) ) vlp; // mapping of the token address => bond address => value.

    pragma solidity ^0.8.0;

// SPDX-License-Identifier: apache 2.0
/*
    Copyright 2022 Debond Protocol <info@debond.org>
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

interface IAPM {
    /**
    fetches the amount of tokens  present of each pair in  the VLP of (tokenA-tokenB).
    @param tokenA address of tokenA
    @param tokenB address of tokenB
    @return reserveA the available amt of tokens in VLP for tokenA.
    @return reserveB the available amt of tokens in VLP for tokenB.
     */
    function getReserves(address tokenA, address tokenB) external view returns (uint reserveA, uint reserveB);

    /**
    updates the composition of the VLP after adding liquidity.
    @dev only callable by bank contract.
    @param _amountA is the amount of tokens of _tokenA in VLP.
    @param _amountB is the amount of tokens of _tokenB in VLP
    @param _tokenA is the address of the first tokenA with _amountA.
     */


    function updateWhenAddLiquidity(
        uint _amountA, 
        uint _amountB,
        address _tokenA,
        address _tokenB) external;

     /**
    updates the composition of the VLP after adding liquidity for the only given underlying collateral.
    @dev only callable by bank contract.
    @param amount is the amount of tokens removed of the given token from the whole VLP.
    @param token is the address of the token for which you want to update the amount.
     */
    function updateWhenRemoveLiquidityForOneToken(
        uint amount, 
        address token) external;

    /**
    executes the swap operation to swap the amounts present in VLP pool pairs.
    @param amount0Out is the residual amount of the token0 that is not swapped (and returned to user).
    @param amount1Out is the fixed swapped amount needed for arbitrary amounnt of conversion of amount0Out   . 
    @param token0 address of collateral of which the 

     */
    function swap(uint amount0Out, uint amount1Out,address token0, address token1, address to) external;

    /**
     @dev gets approximate amount received after adding liquidity  across VLP's defined by path array (path[0]...path[n-1]) VLP's , and their input amount 
     @dev used for getting the parameters  for running swap function
     @param amountIn is the amount of tokens available for path[0] for exchanging  the tokens.
     */

    function removeLiquidity(address _to, address tokenAddress, uint amount) external;
}


```


## Development workflow: 

1. Bank contract calls the `APMRouter.UpdateWhenAddLiquidity/APMRouter.RemoveLiquidity` or  `swapTokensForExactTokens` function to manage the operations like addLiquidity when issed bond, removingLiquidity for 

2.Then internally it calls the  `APM.updateWhenAddLiquidityOneToken() / updateLiquidity()` (based on the type of bond added) function that checks whether there is LP available there, if not it initializes the pair and then updates the liquidity of the virtual pair as well as the whole pool.

3. Similarly during the redemption of the bond: the  UI  interacts with the Bank.redeem..with..() to redeem the bonds (via burning) along with internally calling the `APMRouter.updateWhenRemoveLiquidityOneToken() / updateliquidity()` function that will be updating the overall liquidity along with the VLP.

### Security consideration.
**NOTE:Anyone can put the liquidity in the APM without going through the traditional process of issuing bonds on the bank, its MUST NOT be followed as you will LOOSE THE FUNDS as there are no methods to remove liquidity unless users via banks have to redeem the bond corresponding to liquidity**

## reports: 
1.[markdown report for functions](./docs/APM_report.md).
2.[dependency graph](./docs/APM.png).
3.[APM functioning graph](./docs/APM-graph.png)

### deployment steps : 
1. Add private key info in the .env file (having permissions of the governance) and the settings of RPC provider for the deployment.

2. Insure that test are passing, then deploy the APM as following:
```bash
> truffle deploy deploy/3_deploy_contract.js.
```
3. Then set the corresponding address of dependency `APMRouter`,  `Bank`, `Bond` and `Governance` address (either using etherscan or writing the scripts). 


