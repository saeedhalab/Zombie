const Ownable = artifacts.require("Ownable");

module.exports = function (deployment) {
    deployment.deploy(Ownable);
}