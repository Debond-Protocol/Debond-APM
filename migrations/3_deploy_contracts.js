const APM = artifacts.require("APM");


module.exports = async function (deployer, networks, accounts) {

  const governanceAddress = accounts[0];

  await deployer.deploy(APM, governanceAddress);
  const apmInstance = await APM.deployed();
  const bankInstance = await APM.deployed();

  await apmInstance.setBankAddress(bankInstance.address);

};
