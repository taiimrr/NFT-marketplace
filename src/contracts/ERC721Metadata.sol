// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721Metadata.sol';

contract ERC721Metadata is ERC165,IERC721Metadata {
    string private _name;
    string private _symbol;

    constructor(string memory naming, string memory symboling) {
        _name = naming;
        _symbol = symboling;

        _registerInterface(bytes4(keccak256('name(bytes4)')^keccak256('symbol(bytes4)')));
    }

    function name() view external override returns(string memory) {
        return _name;
        
    }
    function symbol() view external override returns(string memory) {
        return _symbol;
        
    }


}