const ZombieFactory = artifacts.require("ZombieFactory");
const ZombieNames = ["Zombie 1", "Zombie 2"];
const utils = require("./Helper/Utils");
contract("ZombieFactory", (accounts) => {
    let [alice, bob] = accounts;
    let contractInstance;
    beforeEach(async () => {
        contractInstance = await ZombieFactory.new();
    })
    xit("shold be abale to a create new zombie", async () => {
        const result = await contractInstance.createRandomZombie(ZombieNames[0], { from: alice });
        assert.equal(result.receipt.status, true);
        assert.equal(result.logs[0].args.name, ZombieNames[0]);

    })
    xit("shold not allow create two zombie", async () => {
        await contractInstance.createRandomZombie(ZombieNames[0], { from: alice });
        await utils.shouldThrow(contractInstance.createRandomZombie(ZombieNames[1], { from: alice }));
    })
})
