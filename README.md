# optimisation-beefy-merkle-proofs

Comparison of EVM gas costs for verifying Merkle proofs in 2 different proof schemes: multiple single proofs with hash
sorting and multi proofs.

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
2. The number of leaves to prove in the `PROOF_COUNT` constant in the [test contract generation](src/main.rs).
3. The number of test iterations to run in the `TEST_COUNT` constant in the [test contract generation](src/main.rs).

## Running

Generate contract tests:

```sh
cargo run --release
```

Execute tests:

```sh
forge test -vv --gas-report --optimize
```

## Test results

This is based on verifying a random sample of 14 leaves (`PROOF_COUNT`) out of a total of 1000 leaves
(`data::LEAVES.len()`). Results are similar whether sampling 100 or 1000 times (`TEST_COUNT`): multi proofs consume
around 586_000 gas while single proofs consume around 69_000 gas (about 12% of the gas used by multi proofs). Results
from executing tests are below.

Comparing the total gas used by each test shows the same trend, though less significant: around 630_000 gas for multi
proofs and 117_000 gas for single proofs (about 19% of the gas used by multi proofs).

This means that multi proofs are consuming around 5 to 8 times the amount of gas that single proofs consume.

### 100 runs

```
| src/MultiProof.sol:MultiProof contract |                 |        |        |        |         |
|----------------------------------------|-----------------|--------|--------|--------|---------|
| Deployment Cost                        | Deployment Size |        |        |        |         |
| 216857                                 | 1115            |        |        |        |         |
| Function Name                          | min             | avg    | median | max    | # calls |
| verifyProof                            | 488890          | 590445 | 590807 | 675274 | 100     |


| src/SingleProofs.sol:SingleProofs contract |                 |       |        |       |         |
|--------------------------------------------|-----------------|-------|--------|-------|---------|
| Deployment Cost                            | Deployment Size |       |        |       |         |
| 206051                                     | 1061            |       |        |       |         |
| Function Name                              | min             | avg   | median | max   | # calls |
| verifyProofs                               | 68186           | 68896 | 68974  | 68988 | 100     |
```
