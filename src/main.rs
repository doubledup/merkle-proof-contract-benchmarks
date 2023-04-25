use std::fs::File;
use std::io::Write;

use beefy_merkle_tree::{merkle_proof, verify_proof};
use data::LEAVES;
use rs_merkle::{Hasher, MerkleTree};

use tiny_keccak::keccak256;
use rand::{thread_rng, distributions::Uniform, prelude::Distribution};

mod data;

// Number of leaves to use in each test case
const LEAF_COUNT: usize = 14;
// Number of test cases to generate
const TEST_COUNT: usize = 100;

fn main() {
    let mut rng = thread_rng();
    let index_distribution = Uniform::from(0..LEAVES.len());

    for test_number in 0..TEST_COUNT {
        println!("Generating test case #{}", test_number);

        let mut leaf_indices: Vec<usize> = Vec::with_capacity(LEAF_COUNT);
        while leaf_indices.len() < LEAF_COUNT {
            let i = index_distribution.sample(&mut rng);
            if leaf_indices.contains(&i) {
                continue;
            } else {
                leaf_indices.push(i);
            }
        }
        leaf_indices.sort();

        let single_proofs_zeppelin = single_proofs_zeppelin_sorted(leaf_indices.clone());

        File::create(format!("test/SingleProofsZeppelin{}.t.sol", test_number))
            .and_then(|mut single_proof_file| single_proof_file.write_all(single_proofs_zeppelin.as_bytes()))
            .unwrap();

        let single_proofs_solmate = single_proofs_solmate_sorted(leaf_indices.clone());

        File::create(format!("test/SingleProofsSolmate{}.t.sol", test_number))
            .and_then(|mut single_proof_file| single_proof_file.write_all(single_proofs_solmate.as_bytes()))
            .unwrap();

        let multi_proofs = multi_proof_unsorted(leaf_indices);

        File::create(format!("test/MultiProof{}.t.sol", test_number))
            .and_then(|mut multi_proof_file| multi_proof_file.write_all(multi_proofs.as_bytes()))
            .unwrap();
    }
}

fn single_proofs_zeppelin_sorted(leaf_indices: Vec<usize>) -> String {
    let leaves = build_leaves_str_single_proof(leaf_indices.clone());

    let proofs_sorted_hashes = leaf_indices.into_iter()
        .map(|i| merkle_proof::<beefy_merkle_tree::Keccak256, _, _>(data::LEAVES, i));

    let root_hash = proofs_sorted_hashes.clone().peekable().peek().unwrap().root;
    let root = format!("bytes32 root = 0x{};", hex::encode(root_hash));

    let proofs_declaration = format!("bytes32[][] memory proofs = new bytes32[][]({});\n", proofs_sorted_hashes.len());

    let proofs_values = proofs_sorted_hashes
        .clone()
        .enumerate()
        .map(|(i, proof)| {
            let proof_length = proof.proof.len();
            let proof_hashes = proof.proof.into_iter()
                    .enumerate()
                    .map(|(j, hash)| format!("        proofs[{}][{}] = bytes32(0x{});", i, j, hex::encode(hash)))
                    .collect::<Vec<String>>()
                    .join("\n");
            format!("        proofs[{}] = new bytes32[]({});\n{}",
                i,
                proof_length,
                proof_hashes,
            )
        })
        .collect::<Vec<String>>()
        .join("\n\n");

    proofs_sorted_hashes.into_iter().for_each(|proof|{
        let verified = verify_proof::<beefy_merkle_tree::Keccak256, _, _>(&proof.root, proof.proof, proof.number_of_leaves, proof.leaf_index, &proof.leaf);
        assert!(verified);
    });

    format!("// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import \"forge-std/Test.sol\";
import \"src/SingleProofsZeppelin.sol\";

contract SingleProofsZeppelinTest is Test {{
    {}
    SingleProofsZeppelin proofContract;

    function setUp() public {{
        proofContract = new SingleProofsZeppelin();
    }}

    function testSingleProofsZeppelin() public view {{
        {}
        {}
{}

        assert(proofContract.verifyProofs(root, proofs, leaves));
    }}
}}
",
        root,
        leaves,
        proofs_declaration,
        proofs_values,
    )
}

fn build_leaves_str_single_proof(leaf_indices: Vec<usize>) -> String {
    let leaves_hex = leaf_indices.into_iter()
        .filter_map(|i| {
            Some(hex::encode(&data::LEAVES[i]))
        })
        .collect::<Vec<_>>();

    format!("bytes32[] memory leaves = new bytes32[]({});

{}
",
        leaves_hex.len(),
        leaves_hex.into_iter()
            .enumerate()
            .map(|(i, leaf)| format!("        leaves[{}] = keccak256(abi.encode(bytes32(0x{})));", i, leaf))
            .collect::<Vec<_>>()
            .join("\n"))
}

fn single_proofs_solmate_sorted(leaf_indices: Vec<usize>) -> String {
    let leaves = build_leaves_str_single_proof(leaf_indices.clone());

    let proofs_sorted_hashes = leaf_indices.into_iter()
        .map(|i| merkle_proof::<beefy_merkle_tree::Keccak256, _, _>(data::LEAVES, i));

    let root_hash = proofs_sorted_hashes.clone().peekable().peek().unwrap().root;
    let root = format!("bytes32 root = 0x{};", hex::encode(root_hash));

    let proofs_declaration = format!("bytes32[][] memory proofs = new bytes32[][]({});\n", proofs_sorted_hashes.len());

    let proofs_values = proofs_sorted_hashes
        .clone()
        .enumerate()
        .map(|(i, proof)| {
            let proof_length = proof.proof.len();
            let proof_hashes = proof.proof.into_iter()
                    .enumerate()
                    .map(|(j, hash)| format!("        proofs[{}][{}] = bytes32(0x{});", i, j, hex::encode(hash)))
                    .collect::<Vec<String>>()
                    .join("\n");
            format!("        proofs[{}] = new bytes32[]({});\n{}",
                i,
                proof_length,
                proof_hashes,
            )
        })
        .collect::<Vec<String>>()
        .join("\n\n");

    proofs_sorted_hashes.into_iter().for_each(|proof|{
        let verified = verify_proof::<beefy_merkle_tree::Keccak256, _, _>(&proof.root, proof.proof, proof.number_of_leaves, proof.leaf_index, &proof.leaf);
        assert!(verified);
    });

    format!("// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import \"forge-std/Test.sol\";
import \"src/SingleProofsSolmate.sol\";

contract SingleProofsSolmateTest is Test {{
    {}
    SingleProofsSolmate proofContract;

    function setUp() public {{
        proofContract = new SingleProofsSolmate();
    }}

    function testSingleProofsSolmate() public view {{
        {}
        {}
{}

        assert(proofContract.verifyProofs(root, proofs, leaves));
    }}
}}
",
        root,
        leaves,
        proofs_declaration,
        proofs_values,
    )
}

#[derive(Clone)]
struct Keccak256;

impl Hasher for Keccak256 {
    type Hash = [u8; 32];

    fn hash(data: &[u8]) -> [u8; 32] {
        keccak256(data)
    }
}

fn multi_proof_unsorted(leaf_indices: Vec<usize>) -> String {
    let tree = MerkleTree::<Keccak256>::from_leaves(&data::LEAVES.map(|leaf| keccak256(leaf.as_slice())));
    let root = format!("bytes32 root = 0x{};", tree.root_hex().unwrap());

    let leaves = build_leaves_str_multi_proof(leaf_indices.clone());

    let proof = tree.proof_2d(&leaf_indices);

    let proof_declaration = format!("Node[][] memory proof = new Node[][]({});", proof.len());

    let proof_values = proof.clone().into_iter()
        .enumerate()
        .map(|(i, layer)| {
            let declaration = format!("        proof[{}] = new Node[]({});", i, proof.get(i).map_or(0, |proof| proof.len()));
            let nodes =
                layer.into_iter()
                    .enumerate()
                    .map(|(j, (k, hash))| format!("        proof[{}][{}] = Node({{k_index: {}, node: bytes32(0x{})}});", i, j, k, hex::encode(hash)))
                    .collect::<Vec<String>>()
                    .join("\n");
            if nodes.is_empty() {
                declaration
            } else {
                format!("{}\n{}", declaration, nodes)
            }
        })
        .collect::<Vec<String>>()
        .join("\n");

    // TODO: assert that multi proof is correct

    format!("// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import \"forge-std/Test.sol\";
import \"src/MultiProof.sol\";

contract MultiProofTest is Test {{
    {}
    MultiProof proofContract;

    function setUp() public {{
        proofContract = new MultiProof();
    }}

    function testMultiProofs() public view {{
        {}

        {}
{}

        assert(proofContract.verifyProof(root, proof, leaves));
    }}
}}
",
        root,
        leaves,
        proof_declaration,
        proof_values,
    )
}

fn build_leaves_str_multi_proof(leaf_indices: Vec<usize>) -> String {
    let leaves_hex = leaf_indices.into_iter()
        .filter_map(|j| {
            Some((j, hex::encode(&data::LEAVES[j])))
        })
        .collect::<Vec<_>>();

    let declaration = format!("Node[] memory leaves = new Node[]({});", leaves_hex.len());
    let leaves = leaves_hex.into_iter()
        .enumerate()
        .map(|(i, (j, leaf))| format!("        leaves[{}] = Node({{k_index: {}, node: keccak256(abi.encode(bytes32(0x{})))}});", i, j, leaf))
        .collect::<Vec<_>>()
        .join("\n");
    format!("{}\n{}", declaration, leaves)
}
