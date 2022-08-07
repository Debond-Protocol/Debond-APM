const APM = artifacts.require("APM");


module.exports = async function (deployer, networks, accounts) {

  const [governanceAddress, bankAddress] = accounts;

  await deployer.deploy(APM, governanceAddress, bankAddress);
};
