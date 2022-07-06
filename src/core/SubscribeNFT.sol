// SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

import { CyberNFTBase } from "../base/CyberNFTBase.sol";
import { ICyberEngine } from "../interfaces/ICyberEngine.sol";
import { ISubscribeNFT } from "../interfaces/ISubscribeNFT.sol";
import { IProfileNFT } from "../interfaces/IProfileNFT.sol";
import { Constants } from "../libraries/Constants.sol";
import { LibString } from "../libraries/LibString.sol";
import { SubscribeNFTStorage } from "../storages/SubscribeNFTStorage.sol";
import { IUpgradeable } from "../interfaces/IUpgradeable.sol";

/**
 * @title Subscribe NFT
 * @author CyberConnect
 * @notice This contract is used to create a Subscribe NFT.
 */
// This will be deployed as beacon contracts for gas efficiency
contract SubscribeNFT is
    CyberNFTBase,
    SubscribeNFTStorage,
    IUpgradeable,
    ISubscribeNFT
{
    address public immutable ENGINE;
    address public immutable PROFILE_NFT;

    constructor(address engine, address profileNFT) {
        require(engine != address(0), "Engine address cannot be 0");
        require(profileNFT != address(0), "Profile NFT address cannot be 0");
        ENGINE = engine;
        PROFILE_NFT = profileNFT;
        _disableInitializers();
    }

    /// @inheritdoc ISubscribeNFT
    function initialize(uint256 profileId) external override initializer {
        _profileId = profileId;
        // Don't need to initialize CyberNFTBase with name and symbol since they are dynamic
    }

    /// @inheritdoc ISubscribeNFT
    function mint(address to) external override returns (uint256) {
        require(msg.sender == address(ENGINE), "Only Engine could mint");
        super._mint(to);
        return _totalCount;
    }

    /**
     * @notice Gets the subscribe NFT name.
     *
     * @return memory The subscribe NFT name.
     */
    function name() external view override returns (string memory) {
        string memory handle = IProfileNFT(PROFILE_NFT).getHandleByProfileId(
            _profileId
        );
        return
            string(
                abi.encodePacked(handle, Constants._SUBSCRIBE_NFT_NAME_SUFFIX)
            );
    }

    /**
     * @notice Gets the subscribe NFT symbol.
     *
     * @return memory The subscribe NFT symbol.
     */
    function symbol() external view override returns (string memory) {
        string memory handle = IProfileNFT(PROFILE_NFT).getHandleByProfileId(
            _profileId
        );
        return
            string(
                abi.encodePacked(
                    LibString.toUpper(handle),
                    Constants._SUBSCRIBE_NFT_SYMBOL_SUFFIX
                )
            );
    }

    function version() external pure virtual override returns (uint256) {
        return 1;
    }

    /**
     * @notice Generates the metadata json object.
     *
     * @param tokenId The NFT token ID.
     * @return memory The metadata json object.
     * @dev It requires the tokenId to be already minted.
     */
    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        _requireMinted(tokenId);
        return ICyberEngine(ENGINE).getSubscribeNFTTokenURI(_profileId);
    }

    // Subscribe NFT cannot be transferred
    function transferFrom(
        address,
        address,
        uint256
    ) public pure override {
        revert("Transfer is not allowed");
    }
}