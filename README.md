

## Debond-APM.


### Status: 
[test-coverage](https://img.shields.io/github/workflow/status/Debond-Protocol/APM/unit-test?event=push).
[build](https://img.shields.io/github/workflow/status/Debond-Protocol/APM/APMTest).
### About: 
This module consist of smart contract for Automated Pair Maker, which acts as the single consolidated pool (also called Virtual Liquidity Pool ) for all the tokens that are deposited by the user via bank, after they are issued the bond defining the transaction. Along with that it also allows swaps between the different virtual pool pairs between the bond,nonce classes being validated (as purchaseable) by the banks .

**NOTE: Anyone can put the liquidity in the APM without going through the traditional process of issuing bonds on the bank, its MUST NOT be followed as you will LOOSE THE FUNDS as there are no  methods to remove liquidity unless users via   banks have to redeem the bond corresponding to liquidity **
 



## reports: 
1.[markdown report for functions](./docs/APM_report.md).
2.[dependency graph](./docs/APM.png).
3.[APM functioning graph](./docs/APM-graph.png)

### deployment steps : 
1. add private key info in the .env file (having permissions ) and the settings in the 

2. Insure that test are passing, then deploy the APM as following:
```bash
> truffle deploy deploy/3_deploy_contract.js.
```
3. then set the corresponding address of dependency `APMRouter`,  `Bank`, `Bond` and `Governance` address. 

