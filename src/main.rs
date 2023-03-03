use std::io::Write;
use std::fs::File;
use beefy_merkle_tree::{merkle_proof, merkle_root, verify_proof};
use tiny_keccak::keccak256;
use rs_merkle::{Hasher, MerkleTree};

mod data;

fn main() -> std::io::Result<()> {
    let leaf_indices = vec![3, 57, 134];

    let single_proofs = single_proofs_sorted_hashes(leaf_indices.clone());

    let mut single_proof_file = File::create("test/SingleProof.t.sol")?;
    let single_proof_result = single_proof_file.write_all(single_proofs.as_bytes());

    let multi_proofs = multi_proofs_test_contract(leaf_indices);

    let mut multi_proof_file = File::create("test/MultiProof.t.sol")?;
    let multi_proof_result = multi_proof_file.write_all(multi_proofs.as_bytes());

    single_proof_result.and(multi_proof_result)
}

fn single_proofs_sorted_hashes(leaf_indices: Vec<usize>) -> String {
    let leaves = build_leaves_str(leaf_indices.clone());

    let root = format!("bytes32 root = 0x{};", hex::encode(merkle_root::<beefy_merkle_tree::Keccak256, _>(data::LEAVES)));

    let proofs_sorted_hashes = leaf_indices.into_iter()
        .map(|i| merkle_proof::<beefy_merkle_tree::Keccak256, _, _>(data::LEAVES, i));

    let proof_arrays = proofs_sorted_hashes
        .clone()
        .enumerate()
        .map(|(i, proof)| {
            format!("    bytes32[] proof{} = [ {} ];",
                i,
                proof.proof.into_iter()
                    .map(|hash| format!("bytes32(0x{})", hex::encode(hash)))
                    .collect::<Vec<String>>()
                    .join(", "))
        })
        .collect::<Vec<String>>()
        .join("\n");

    let all_proofs = format!("bytes32[][] proofs = [ {} ];\n", (0..proofs_sorted_hashes.len())
        .map(|i| {
            format!("proof{}", i)
        })
        .collect::<Vec<String>>()
        .join(", "));

    proofs_sorted_hashes.into_iter().for_each(|proof|{
        let verified = verify_proof::<beefy_merkle_tree::Keccak256, _, _>(&proof.root, proof.proof, proof.number_of_leaves, proof.leaf_index, &proof.leaf);
        assert!(verified);
    });

    format!("// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import \"forge-std/Test.sol\";
import \"openzeppelin/utils/cryptography/MerkleProof.sol\";

contract SingleProofsTest is Test {{
    {}
    {}
{}
    {}
    function testSingleProofs() public view {{
        for (uint i = 0; i < leaves.length; ++i) {{
            assert(MerkleProof.verify(proofs[i], root, keccak256(abi.encode(leaves[i]))));
        }}
    }}
}}
",
        leaves,
        root,
        proof_arrays,
        all_proofs,
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

fn multi_proofs_test_contract(leaf_indices: Vec<usize>) -> String {
    let leaves = build_leaves_str(leaf_indices.clone());

    let tree = MerkleTree::<Keccak256>::from_leaves(&data::LEAVES.map(|leaf| keccak256(leaf.as_slice())));
    let root = format!("bytes32 root = 0x{};", tree.root_hex().unwrap());

    let proofs = tree.proof_2d(&leaf_indices);

    let proof_arrays = proofs.clone().into_iter()
        .enumerate()
        .map(|(i, layer)| format!("    bytes32[] proof{} = [ {} ];",
            i,
            layer.into_iter()
                .map(|(j, hash)| format!("({}, bytes32(0x{}))", j, hex::encode(hash)))
                .collect::<Vec<String>>()
                .join(", ")
        ))
        .collect::<Vec<String>>()
        .join("\n");

    let all_proofs = format!("bytes32[][] proofs = [ {} ];\n", (0..proofs.len())
        .map(|i| {
            format!("proof{}", i)
        })
        .collect::<Vec<String>>()
        .join(", "));

    format!("// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import \"forge-std/Test.sol\";
import \"forge-std/console.sol\";

contract MultiProofsTest is Test {{
    {}
    {}
{}
    {}
    function testMultiProofs() public view {{
        for (uint i = 0; i < leaves.length; ++i) {{
            assert(MerkleProof.verify(proofs[i], root, keccak256(abi.encode(leaves[i]))));
        }}
    }}
}}
",
        leaves,
        root,
        proof_arrays,
        all_proofs,
    )
}

fn build_leaves_str(leaf_indices: Vec<usize>) -> String {
    let leaves_hex = data::LEAVES.into_iter()
        .enumerate()
        .filter_map(|(i, leaf)| {
            if leaf_indices.contains(&i) {
                Some(hex::encode(&leaf))
            } else {
                None
            }
        })
        .collect::<Vec<_>>();

    format!("bytes32[] leaves = [ {} ];\n",
        leaves_hex.into_iter()
            .map(|leaf| format!("bytes32(0x{})", leaf))
            .collect::<Vec<_>>()
            .join(", "))
}
