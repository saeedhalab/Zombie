//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
import "./ZombieHelper.sol";

contract ZombieAttack is ZombieHelper {
    uint256 randNonce = 0;
    uint256 attackVictoryProbability = 70;

    function randMod(uint256 _modulus) internal returns (uint256) {
        randNonce++;
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.timestamp, msg.sender, randNonce)
                )
            ) % _modulus;
    }

    function attack(uint256 _zombieId, uint256 _targetId)
        external
        isOwnerZombie(_zombieId)
    {
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint256 randNumber = randMod(100);
        if (randNumber < attackVictoryProbability) {
            myZombie.winCount++;
            myZombie.level++;
            enemyZombie.losCount++;
        } else {
            myZombie.losCount++;
            enemyZombie.winCount++;
        }
        _feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    }
}
