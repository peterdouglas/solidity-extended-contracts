var DemoToken = artifacts.require("./DemoToken.sol");

module.exports = function(deployer) {
  deployer.deploy(DemoToken, 10000000000000000000000);

};
