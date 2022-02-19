// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {

event Transfer(address indexed from, address indexed to,uint256 indexed tokenId);

    mapping (uint256 => address) private _tokenOwner;
    mapping (address => uint256) private _ownerTokensCount;


    function balanceOf(address _owner) public view returns (uint256){
       require(_owner != address(0));
      
        return _ownerTokensCount[_owner];
    }

    function ownerOf(uint256 tokenId) view public returns (address){
        require(_tokenOwner[tokenId] != address(0));
        return _tokenOwner[tokenId];
    }
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), 'Insert a valid address');
        require(_tokenOwner[tokenId] == address(0),'Token Already minted');
        _tokenOwner[tokenId] = to;
        _ownerTokensCount[to] += 1; 

        emit Transfer(address(0), to, tokenId);
    }
}