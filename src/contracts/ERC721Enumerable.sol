// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is ERC721,  IERC721Enumerable{

    uint[] private _allTokens; 
    mapping (uint256 => uint256) private _allTokenIndex;
    mapping (address => uint256[]) private ownerTokenIds;
    mapping (uint256 => uint256) private _ownedTokensIndex;

    constructor(){
        _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^keccak256('tokenByIndex(bytes4)')^keccak256('tokenOfOwnerByIndex(bytes4)')));
    }


    function totalSupply() external view override returns (uint256){
        return _allTokens.length;
    }

    function _mint(address to, uint256 tokenId) internal override(ERC721){
            super._mint(to,tokenId);

            addTokensToAllTokenEnumeration(tokenId);
            addTokensToOwnerEnumeration(to,tokenId);
    }

    function tokenByIndex(uint256 index) view override public returns(uint256){
        require(index < this.totalSupply(), 'Index out of bounds!');
        return _allTokens[index];
    }
    function tokenOfOwnerByIndex(address owner,uint256 index) view override public returns(uint256){
        require(index < this.balanceOf(owner), 'Index out of bounds!');
        return ownerTokenIds[owner][index];
    }

    function addTokensToAllTokenEnumeration(uint256 tokenId ) private{
        _allTokenIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function addTokensToOwnerEnumeration(address to, uint256 tokenId) private{
        _ownedTokensIndex[tokenId] = ownerTokenIds[to].length;
        ownerTokenIds[to].push(tokenId);

    }
}
