// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title IntelligenceAsset - Ultra-Minimal Asset Registry
/// @dev Bare-minimum on-chain tracking for content ownership and integrity
/// Storage on blockchain: creator, fingerprint, timestamp
/// All other data stored off-chain in backend database
contract IntelligenceAsset {
    // State counter
    uint256 public tokenIdCounter = 1;

    // Core storage: tokenId => data
    mapping(uint256 => address) public creators;           // who created the asset
    mapping(uint256 => string) public fingerprints;        // content integrity proof (hash)
    mapping(uint256 => uint256) public createdAt;          // creation timestamp

    // Event: only fired when asset is minted
    event AssetMinted(
        uint256 indexed tokenId,
        address indexed creator,
        string fingerprint,
        uint256 timestamp
    );

    /// @notice Mint a new intelligence asset
    /// @param _creator Creator wallet address
    /// @param _fingerprint Content hash/fingerprint (SHA256 of actual content)
    /// @return tokenId The newly assigned token ID
    function mintAsset(
        address _creator,
        string calldata _fingerprint
    ) external returns (uint256) {
        require(_creator != address(0), "Invalid creator");
        require(bytes(_fingerprint).length > 0, "Fingerprint required");

        uint256 tokenId = tokenIdCounter;
        tokenIdCounter++;

        // Store minimal data on-chain
        creators[tokenId] = _creator;
        fingerprints[tokenId] = _fingerprint;
        createdAt[tokenId] = block.timestamp;

        // Emit proof of minting
        emit AssetMinted(tokenId, _creator, _fingerprint, block.timestamp);

        return tokenId;
    }

    /// @notice Verify an asset exists and get its creator
    function getAsset(uint256 _tokenId) external view returns (address creator, string memory fingerprint, uint256 timestamp) {
        require(creators[_tokenId] != address(0), "Asset does not exist");
        return (creators[_tokenId], fingerprints[_tokenId], createdAt[_tokenId]);
    }

    /// @notice Check if asset exists
    function exists(uint256 _tokenId) external view returns (bool) {
        return creators[_tokenId] != address(0);
    }

    /// @notice Get current next token ID
    function getCurrentTokenId() external view returns (uint256) {
        return tokenIdCounter;
    }
}
