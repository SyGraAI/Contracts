# SyGra Contracts

Solidity source and deployment details for the asset registry used by [SyGra Marketplace](https://app.sygra.org/). The registry records a creator address, content fingerprint, and registration timestamp on Robinhood Chain.

## Deployment

| Field | Value |
| --- | --- |
| Network | Robinhood Chain Mainnet |
| Chain ID | 4663 |
| Address | [`0x1A55eb5C50BD266C2fFd25a125820ACFffab1bF5`](https://robinscanner.com/addresses/0x1a55eb5c50bd266c2ffd25a125820acfffab1bf5?tab=contract) |
| Deployment transaction | [`0x8e7054986110633bb6ee398795e28ff0283652c2925a769d0ae44dec66db94c9`](https://robinscanner.com/tx/0x8e7054986110633bb6ee398795e28ff0283652c2925a769d0ae44dec66db94c9) |
| Deployment block | 104294370 |

## Source and verification

The reference source was compiled with Solidity `0.8.19+commit.7dd6d404`, the optimizer disabled, and the Paris EVM target. The executable portions of its creation and runtime bytecode match the corresponding bytes from the deployment transaction and the mainnet RPC. The trailing Solidity CBOR metadata differs, so the full bytecode comparison does not establish the exact original source text or build settings. The explorer currently displays the contract as unverified.

## Build

With Solidity compiler 0.8.19 installed, run from the repository root:

```sh
solc --evm-version paris --abi --bin --bin-runtime -o build IntelligenceAsset.sol
```

`abi/IntelligenceAsset.json` contains the interface generated from the reference source. `deployments/robinhood-mainnet.json` records the observed deployment and bytecode comparison. Each SHA-256 digest is computed from the decoded bytecode bytes. To reproduce the executable comparison, remove the Solidity CBOR trailer and its two-byte big-endian length from both creation bytecodes and from both runtime bytecodes before comparing each pair.

## License

The Solidity source is distributed under the [MIT License](LICENSE).
