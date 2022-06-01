const APM = artifacts.require("APM");
const BankRouter = artifacts.require("BankRouter");


module.exports = async function (deployer, networks, accounts) {

  const governanceAddress = accounts[0];

  await deployer.deploy(APM, governanceAddress);
  const apmInstance = await APM.deployed();
  await deployer.deploy(BankRouter, apmInstance.address);
  const bankInstance = await APM.deployed();

  await apmInstance.setBankAddress(bankInstance.address);

};
