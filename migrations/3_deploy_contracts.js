const APM = artifacts.require("APM");
const APMRouter = artifacts.require("APMRouter");


module.exports = async function (deployer, networks, accounts) {

  const governanceAddress = accounts[0];

  await deployer.deploy(APM, governanceAddress);
  const apmInstance = await APM.deployed();
  await deployer.deploy(APMRouter, apmInstance.address);
  const bankInstance = await APM.deployed();

  await apmInstance.setBankAddress(bankInstance.address);

};
