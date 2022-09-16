const APM = artifacts.require("APM");


module.exports = async function (deployer, networks, accounts) {

  const [governanceAddress, bankAddress, governanceExecutableAddress] = accounts;

  await deployer.deploy(APM, governanceAddress, bankAddress/*, governanceExecutableAddress*/);
};
