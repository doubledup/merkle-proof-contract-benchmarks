// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "solidity-merkle-trees/MerkleMultiProof.sol";
import "openzeppelin/utils/cryptography/MerkleProof.sol";

contract SingleProofs {
    constructor() {
    }

    function verifyProofs(bytes32 root, bytes32[][] memory proofs, bytes32[] memory leaves)
        public
        pure
        returns (bool)
    {
        bool verified = true;
        for (uint i = 0; i < leaves.length; ++i) {
            verified = verified && MerkleProof.verify(proofs[i], root, keccak256(abi.encode(leaves[i])));
        }
        return verified;
    }
}
