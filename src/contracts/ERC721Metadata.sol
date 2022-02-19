// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721Metadata {
    string private _name;
    string private _symbol;

    constructor(string memory naming, string memory symboling) {
        _name = naming;
        _symbol = symboling;
    }

    function name() view external returns(string memory) {
        return _name;
        
    }
    function symbol() view external returns(string memory) {
        return _symbol;
        
    }


}