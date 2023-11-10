// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    // Sự kiện này sẽ được phát ra khi một NFT mới được mint
    event NFTMinted(uint256 indexed tokenId, address indexed owner, string tokenURI);

    Counters.Counter private currentTokenId;
    string private baseTokenURI;

    constructor() ERC721("MyNFT", "MNFT") {
        // Thiết lập một baseTokenURI mặc định nếu muốn
        baseTokenURI = "";
    }

    function mintNFT(string memory tokenURI) public returns (uint256) {
        currentTokenId.increment();
        uint256 newItemId = currentTokenId.current();
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        emit NFTMinted(newItemId, msg.sender, tokenURI); // Phát ra sự kiện khi NFT được mint
        return newItemId;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function setBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    // Các hàm và override bổ sung có thể được thêm vào nếu cần
}
