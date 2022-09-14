import {
    APMInstance,
    DBITInstance,
    USDCInstance,
    USDTInstance
} from "../types/truffle-contracts";

const USDC = artifacts.require("USDC");
const USDT = artifacts.require("USDT");
const DBIT = artifacts.require("DBIT");
const APM = artifacts.require("APM");

contract('APM', async (accounts: string[]) => {

    let usdcContract: USDCInstance
    let usdtContract: USDTInstance
    let dbitContract: DBITInstance
    let apmContract : APMInstance
    const [governanceAddress, bankAddress] = accounts;

    before('Initialisation', async () => {
        usdcContract = await USDC.deployed();
        usdtContract = await USDT.deployed();
        dbitContract = await DBIT.deployed();
        apmContract = (await APM.deployed());
    })

    it('update add liquidity', async () => {

        await usdcContract.mint(apmContract.address, '100');
        await dbitContract.mint(apmContract.address, '10000');

        const s = await apmContract.getReserves(usdcContract.address, dbitContract.address);
        console.log("here we print r0 before addLiqq : " +  s[0].toString(),"here we print r1 before addliq :" + s[1].toString());

        await apmContract.updateWhenAddLiquidity(100, 10000, usdcContract.address, dbitContract.address, {from: bankAddress});
        const r = await apmContract.getReserves(usdcContract.address, dbitContract.address);
        console.log("here we print r0 after addliq : " +  r[0].toString(),"here we print r1 after addliq :" + r[1].toString());

        const usdcBalance = r[0].toString();
        const dbitBalance = r[1].toString();
        expect(usdcBalance).to.equal('100');
        expect(dbitBalance).to.equal('10000');

        let balanceUSDC = await usdcContract.balanceOf(apmContract.address);
        let balanceDBIT = await dbitContract.balanceOf(apmContract.address);

        console.log("balanceUSDC : " +  balanceUSDC);

        console.log("balanceDBIT : " +  balanceDBIT);




    })
    it('should remove liquidity from the APM and update the reserves accordingly', async () => {
        usdcContract = await USDC.deployed();
        dbitContract = await DBIT.deployed();
        apmContract = (await APM.deployed());

        await dbitContract.mint(apmContract.address, 5000);

        const s = await apmContract.getReserves(usdcContract.address, dbitContract.address);
        console.log("here we print r0 before remove : " +  s[0].toString(),"here we print r1 before remove : " + s[1].toString());

        await apmContract.removeLiquidity(accounts[3],  dbitContract.address, 5000, {from: governanceAddress});

        const r = await apmContract.getReserves(usdcContract.address, dbitContract.address);
        console.log("here we print r0 after remove : " +  r[0].toString(),"here we print r1 after remove : " + r[1].toString());

        const dbitBalance = r[1].toString();
        expect(dbitBalance).to.equal('5000');

        const usdcBalance = r[0].toString();
        expect(usdcBalance).to.equal('100');


    })

    it('update add liquidity', async () => {
        const s = await apmContract.getReserves(usdtContract.address, dbitContract.address);
        console.log("here we print r0 before addLiqq : " +  s[0].toString(),"here we print r1 before addliq :" + s[1].toString());

        await usdtContract.mint(apmContract.address, '100');
        await dbitContract.mint(apmContract.address, '5000'); //we mint 10 000 but there are already 5000 removed from previous test that we didn' really removed


        await apmContract.updateWhenAddLiquidity(100, 10000, usdtContract.address, dbitContract.address, {from: bankAddress});


        let balanceUSDT = await usdtContract.balanceOf(apmContract.address);
        let balanceDBIT = await dbitContract.balanceOf(apmContract.address);
        console.log("balanceUSDT : " +  balanceUSDT);
        console.log("balanceDBIT : " +  balanceDBIT);


        const r = await apmContract.getReserves(usdtContract.address, dbitContract.address);
        console.log("here we print r0 after addliq : " +  r[0].toString(),"here we print r1 after addliq :" + r[1].toString());

        const usdtBalance = r[0].toString();
        const dbitBalance = r[1].toString();
        expect(usdtBalance).to.equal('100');
        expect(dbitBalance).to.equal('10000');
    })
});
