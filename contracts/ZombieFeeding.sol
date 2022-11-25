//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
import "./ZombieFactory.sol";
import "./Ownable.sol";

interface KityInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

contract ZombieFeeding is ZombieFactory,Ownable {
    KityInterface kittyContract;

    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KityInterface(_address);
    }

    function _triggercooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(block.timestamp + cooldownTime);
    }

    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (block.timestamp >= _zombie.readyTime);
    }

    //create new dna and create new zombie with old zombie and target zombie
    //checked if zombie eat kitty we calculate dna and last two number shuld 99
    function _feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) internal {
        require(zombieToOwner[_zombieId] == msg.sender);
        Zombie storage myZombie = zombies[_zombieId];
        require(_isReady(myZombie));
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        if (
            keccak256(abi.encodePacked(_species)) ==
            keccak256(abi.encodePacked("kitty"))
        ) {
            newDna = newDna - (newDna % 100) + 99;
        }
        _createZombie("noname", newDna);
        _triggercooldown(myZombie);
    }

    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        _feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
