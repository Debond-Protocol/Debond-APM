const APM = artifacts.require("APM");


module.exports = async function (deployer, networks, accounts) {

  const [executableAddress, bankAddress, stakingDebondAddress] = accounts;

  await deployer.deploy(APM, executableAddress, bankAddress, stakingDebondAddress);
};
