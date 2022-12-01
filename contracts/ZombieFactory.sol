//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./SafeMath.sol";

contract ZombieFactory {
    using SafeMath for uint256;
    event newZombie(uint256 zombieId, string name, uint256 dna);
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;
    uint256 cooldownTime = 1 days;
    struct Zombie {
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 losCount;
    }
    Zombie[] public zombies;
    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) ownerZombieCount;

    modifier isOwnerZombie(uint256 _zombieId) {
        require(zombieToOwner[_zombieId] == msg.sender);
        _;
    }

    function _createZombie(string memory _name, uint256 _dna) internal {
        zombies.push(
            Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0)
        );
        uint256 id = (zombies.length) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit newZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
