# optimisation-beefy-merkle-proofs

Comparison of EVM gas costs for verifying Merkle proofs in 2 different proof schemes: multiple single proofs with hash
sorting and multi proofs without hash sorting.

The Merkle tree that's used for single proofs has sorted hash pairs. This changes the structure of the Merkle trees
used, effectively randomly swapping every pair of sibling subtrees. eg. what would have been

```
          567
        /     \
    789         234
   /   \
123     456
```

becomes

```
          890
        /     \
    234         789
               /   \
            123     456
```

Since `123` and `456` are already sorted, they retain their order and their parent hash is the same. But `789` and `234`
are not sorted, so they're swapped, bringing all of their child nodes with them. Because their order is changed, their
parent hash changes, in this example from `567` to `890`.

## Setup

Requires Rust and Foundry. Run `forge install` once to fetch contract dependencies.

## Test data

There are 3 ways to change inputs to the tests:

1. The leaves used in the [sample data](src/data.rs).
2. The number of leaves to prove in the `LEAF_COUNT` constant in the [test contract generation](src/main.rs).
3. The number of test iterations to run in the `TEST_COUNT` constant in the [test contract generation](src/main.rs).

## Running

Generate contract tests:

```sh
cargo run --release --bin merkle-proof-contract-benchmarks
```

Execute tests:

```sh
forge test -vv --gas-report --optimize
```

## Test results

This is based on verifying a random sample of 14 leaves (`LEAF_COUNT`) out of a total of 1000 leaves
(`data::LEAVES.len()`). Results are similar whether sampling 100 or 1000 times (`TEST_COUNT`): multi proofs consume
around 106_000 gas while single proofs consume around 68_000 gas in OpenZeppelin's implementation (about 64% of the gas
used by multi proofs) and around 26_000 gas in Solmate's implementation (about 25% of the gas used by multi proofs).
Results from executing the tests are below.

When proving relatively few of a large number of leaves, multi proofs consume around 2 to 4 times the amount of gas that
single proofs do.

### 100 runs

```
| src/MultiProof.sol:MultiProof contract |                 |        |        |        |         |
|----------------------------------------|-----------------|--------|--------|--------|---------|
| Deployment Cost                        | Deployment Size |        |        |        |         |
| 216857                                 | 1115            |        |        |        |         |
| Function Name                          | min             | avg    | median | max    | # calls |
| verifyProof                            | 106839          | 106839 | 106839 | 106839 | 100     |


| src/SingleProofsSolmate.sol:SingleProofsSolmate contract |                 |       |        |       |         |
|----------------------------------------------------------|-----------------|-------|--------|-------|---------|
| Deployment Cost                                          | Deployment Size |       |        |       |         |
| 161008                                                   | 836             |       |        |       |         |
| Function Name                                            | min             | avg   | median | max   | # calls |
| verifyProofs                                             | 26271           | 26271 | 26271  | 26271 | 100     |


| src/SingleProofsZeppelin.sol:SingleProofsZeppelin contract |                 |       |        |       |         |
|------------------------------------------------------------|-----------------|-------|--------|-------|---------|
| Deployment Cost                                            | Deployment Size |       |        |       |         |
| 180026                                                     | 931             |       |        |       |         |
| Function Name                                              | min             | avg   | median | max   | # calls |
| verifyProofs                                               | 67920           | 67920 | 67920  | 67920 | 100     |
```
