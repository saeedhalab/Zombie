const ZombieAttack = artifacts.require("ZombieAttack");

module.exports = function (deployment) {
    deployment.deploy(ZombieAttack);
}