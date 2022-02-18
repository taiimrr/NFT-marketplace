// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721connector.sol';


contract Kryptobird is ERC721connector {

    constructor() ERC721connector("Kryptobird","KRYPTOZ") {
     
    }
}