//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

abstract contract ERC721 {
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _zombieId
    );
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 indexed _zombieId
    );

    function balanceOf(address _owner) external view virtual returns (uint256);

    function ownerOf(uint256 _zombieId) external view virtual returns (address);

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable virtual;
   function approve(address _approved, uint256 _zombieId) external virtual  payable;
}
