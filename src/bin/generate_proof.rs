use beefy_merkle_tree::merkle_proof;

use merkle_proof_contract_benchmarks::data::NUMBER_LEAVES;

const LEAF_INDEX: usize = 41;

// Generate a single proof for a leaf with value `LEAF` from leaves with values 1..TOTAL_LEAVES
pub fn main() {
    let proof = merkle_proof::<beefy_merkle_tree::Keccak256, _, _>(NUMBER_LEAVES, LEAF_INDEX);
    println!("Root: {:?}", proof.root);
    println!("Proof: {:?}", proof.proof);
    println!("Leaf: {:?}", proof.leaf);
}
