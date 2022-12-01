//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./ZombieAttack.sol";
import "./erc721.sol";

contract ZombieOwnerShip is ZombieAttack, ERC721 {
    mapping(uint256 => address) zombieApprovals;

    function balanceOf(address _owner)
        external
        view
        override
        returns (uint256)
    {
        return ownerZombieCount[_owner];
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _zombieId
    ) external payable {
        require(_to != address(0));
        require(
            zombieToOwner[_zombieId] == msg.sender ||
                zombieApprovals[_zombieId] == msg.sender
        );
        _transfer(_from, _to, _zombieId);
    }

    function ownerOf(uint256 _zombieId)
        external
        view
        override
        returns (address)
    {
        return zombieToOwner[_zombieId];
    }

    function _transfer(
        address _from,
        address _to,
        uint256 _zombieId
    ) private {
        ownerZombieCount[_to]++;
        ownerZombieCount[_from]--;
        zombieToOwner[_zombieId] = _to;
        emit Transfer(_from, _to, _zombieId);
    }

    function approve(address _approved, uint256 _zombieId)
        external
        payable
        virtual
        isOwnerZombie(_zombieId)
    {
        zombieApprovals[_zombieId] = _approved;
        emit Approval(msg.sender, _approved, _zombieId);
    }
}
