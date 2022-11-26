
const ZombieFeeding = artifacts.require("ZombieFeeding");

module.exports = function (deployment) {
    deployment.deploy(ZombieFeeding);
}