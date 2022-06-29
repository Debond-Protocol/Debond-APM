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
    @param _amountA is the amount of tokens of _tokenA in VLP.
    @param _amountB is the amount of tokens of _tokenB in VLP
    @param _tokenA is the address of the first tokenA with _amountA.
     */
    function updateWhenRemoveLiquidity(
        uint amount, 
        address token) external;

    /**
    executes the swap operation between the token0,token1 given we define the corresponding outputs (amount0Out, amount1Out) and transfer to given address.
     */
    function swap(uint amount0Out, uint amount1Out,address token0, address token1, address to) external;

    /**
     gets approximate amount received after swapping across VLP's defined by path , and amountIn of path[0] token.
     used for getting the parameters  for running swap function
     */

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    /**
    updates the whole reserve of given tokenAddress with amount (which is being distributed across different VLP's).
     */
    function updateTotalReserve(address tokenAddress, uint amount) external;

    /**
    allows the bank to remove liquidity from the consolidated pool.
     */

    function removeLiquidity(address _to, address tokenAddress, uint amount) external;
}
