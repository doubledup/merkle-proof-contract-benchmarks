# optimisation-beefy-merkle-proofs
Comparison of EVM gas costs for verifying Merkle proofs in different proof schemes

Requires Rust and Foundry. Run `forge install` once to fetch contract dependencies.

Generate contract tests:

```sh
cargo run
```

Execute tests:

```sh
forge test -vv --gas-report --optimize
```
