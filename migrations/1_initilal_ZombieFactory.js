const ZombieFactory = artifacts.require("ZombieFactory");

module.exports = function (deployment) {
    deployment.deploy(ZombieFactory);
}