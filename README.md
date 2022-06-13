# CyberConnect Contracts

This hosts all contracts for CyberConnect's social graph protocol.

Some opinions:
1. Prefer require for semantic clearity. 
2. No custom error until require supports custom error.
3. NFTs don't support burn
4. Try to be gas efficient :)


# Dependencies

[Foundry](https://github.com/foundry-rs/foundry) ([book](https://book.getfoundry.sh/))


# Usage

To build
`forge build`

To test
`forge test`

# TODO
- [x] BaseNFT
- [x] Validate handle (lower-case alphabetical, numerical, _)
- [ ] Governance, Pausable
- [ ] Mint with Signature
- [ ] SVG generation
- [ ] Purchase logic
- [ ] SBT NFT
- [ ] SBT Module
- [x] Onchain Token URI
- [ ] Permit with EIP712
- [ ] Upgradeable and Proxy (UUPS)
- [ ] Crosschain support (openzeppelin contract) (https://docs.openzeppelin.com/contracts/4.x/api/crosschain)
- [ ] Events
- [ ] BoxNFT

- [ ] Hardhat plugin, add license
- [ ] linter