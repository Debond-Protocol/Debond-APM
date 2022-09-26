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
