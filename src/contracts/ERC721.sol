// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import './ERC165.sol';
import './interfaces/IERC721.sol';




contract ERC721 is ERC165,IERC721 {



    mapping (uint256 => address) private _tokenOwner;
    mapping (address => uint256) private _ownerTokensCount;
    mapping (uint256 => address) private _tokenApprovals;

     constructor(){
        _registerInterface(bytes4(keccak256('balanceOf(bytes4)')^keccak256('ownerOf(bytes4)')^keccak256('transferFrom(bytes4)')));
    }


    function balanceOf(address _owner) public override view returns (uint256){
       require(_owner != address(0));
      
        return _ownerTokensCount[_owner];
    }

    function ownerOf(uint256 tokenId) view override public returns (address){
        require(_tokenOwner[tokenId] != address(0));
        return _tokenOwner[tokenId];
    }
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), 'Insert a valid address');
        require(_tokenOwner[tokenId] == address(0),'Token Already minted');
        _tokenOwner[tokenId] = to;
        _ownerTokensCount[to] += 1; 

        emit Transfer(address(0), to, tokenId);
    }

     function _transferFrom(address _from, address _to, uint256 _tokenId) internal{
        require(_to != address(0), 'Insert a valid address');
        require(ownerOf(_tokenId) == _from,"Onwer address is incorrect!!");

        _tokenOwner[_tokenId] = _to;
        _ownerTokensCount[_from] -= 1; 
        _ownerTokensCount[_to] += 1; 

         emit Transfer(_from, _to, _tokenId);



    }

    function transferFrom(address _from, address _to, uint256 _tokenId) override public {
        _transferFrom( _from,  _to,  _tokenId);
    }

    function approve(address _to, uint256 tokenId) public{
        address owner = ownerOf(tokenId);
        require(_to != owner,"Error: Approval to same address!");
        require(owner == msg.sender,"You must be owner to approve this!!");      
        _tokenApprovals[tokenId] = _to;  

        emit Approval(owner, _to, tokenId);

    }
    function _exists(uint256 tokenId) internal view returns(bool){
        return (_tokenOwner[tokenId] != address(0));
    }
    
    function isApprovedOrOwner(address spender, uint256 tokenId) internal view returns(bool){
        require(_exists(tokenId));
        address owner = ownerOf(tokenId);
        return(spender == owner || _tokenApprovals[tokenId] == spender);
    }
}