const ZombieHelper = artifacts.require("ZombieHelper");

module.exports = function (deployment) {
    deployment.deploy(ZombieHelper);
}