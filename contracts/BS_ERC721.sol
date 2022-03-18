// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
 
 
contract BlueSurgeNFT{
 
  // My Variables
    string public name;
    string public symbol;
    mapping (uint256 => string) internal idToUri; 
    string constant NOT_VALID_NFT = "003002";

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping (uint256 => address) internal idToOwner;

    constructor() {
        name = "BlueSurgeToken";
        symbol = "BST";
    }

    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }

    function ownerOf(uint256 tokenId) public view virtual returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }

    function balanceOf(address owner) public view virtual returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");
        return _balances[owner];
    }

    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return _owners[tokenId] != address(0);
    }

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");

        _beforeTokenTransfer(address(0), to, tokenId);

        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);

        _afterTokenTransfer(address(0), to, tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {}

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {}

    
  modifier validNFToken(
    uint256 _tokenId
  )
  {
    require(idToOwner[_tokenId] != address(0), NOT_VALID_NFT);
    _;
  }

   
  function _setTokenUri(
    uint256 _tokenId,
    string memory _uri
  )
    internal
  {
    idToUri[_tokenId] = _uri;
  }

    function mint(address _to, uint256 _tokenId, string calldata _uri) external {
        _mint(_to, _tokenId);
        _setTokenUri(_tokenId, _uri);
    }

    function tokenURI(
    uint256 _tokenId
  )
    external
    view
    returns (string memory)
  {
    return _tokenURI(_tokenId);
  }

  function _tokenURI(uint256 _tokenId)internal virtual view returns (string memory){
    return idToUri[_tokenId];
  }

}
