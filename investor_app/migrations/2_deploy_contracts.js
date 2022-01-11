const RDX = artifacts.require("InvestorToken");

module.exports = async function (deployer, network, accounts) {
  // Deploy Mock Tether Token
  await deployer.deploy(RDX);
  const rdx = await RDX.deployed();

};
