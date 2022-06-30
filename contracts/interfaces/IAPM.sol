pragma solidity ^0.8.0;

// SPDX-License-Identifier: apache 2.0
/*
    Copyright 2020 Sigmoid Foundation <info@SGM.finance>
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
    updates the composition of the VLP after adding liquidity.
    @dev only callable by bank contract.
    @param amount is the amount of tokens removed of the given token from the whole VLP.
    @param token is the address of the token for which you want to update the amount.
     */
    function updateWhenRemoveLiquidity(
        uint amount, 
        address token) external;

    /**
    executes the swap operation to swap the amounts present in VLP pool pairs.
    @param amount0Out is the residual amount of the token0 that is not swapped (and returned to user).
    @param amount1Out is the swapped amount from amount0Out , token0 in order to fetch the results. 
     */
    function swap(uint amount0Out, uint amount1Out,address token0, address token1, address to) external;

    /**
     @dev gets approximate amount received after adding liquidity  across VLP's defined by path array (path[0]...path[n-1]) VLP's , and their input amount 
     @dev used for getting the parameters  for running swap function
     @param amountIn is the amount of tokens available for path[0] for exchanging  the tokens.
     */

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    /**
    updates the whole reserve of given tokenAddress with amount that is added.
    @dev
     */
    function updateTotalReserve(address tokenAddress, uint amount) external;

    /**
    allows the bank to remove liquidity from the consolidated pool.
    @param onlyBank modifier MUST be used.
    @param _to is the  address fetching the liquidity out of APM
    @param tokenAddress is the address of token whose amount is to be withdrawn from APM.
    @param amount is the number of tokens withdrawn from `tokenAddress`are to be removed.
     */

    function removeLiquidity(address _to, address tokenAddress, uint amount) external;
}
