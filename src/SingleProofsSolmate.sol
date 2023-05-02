// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "solmate/utils/MerkleProofLib.sol";

contract SingleProofsSolmate {
    constructor() {
    }

    function verifyProofs(bytes32 root, bytes32[][] calldata proofs, bytes32[] memory leaves)
        public
        pure
        returns (bool)
    {
        bool verified = true;
        for (uint i = 0; i < leaves.length; ++i) {
            verified = verified && MerkleProofLib.verify(proofs[i], root, leaves[i]);
        }
        return verified;
    }

    function verifyRoots(bytes32 root, bytes32[][] calldata proofs, bytes32[] memory leaves)
        public
        pure
        returns (bool)
    {
        bool verified = true;
        for (uint i = 0; i < leaves.length; ++i) {
            verified = verified && MerkleProofLib.calculateRoot(proofs[i], leaves[i]) == root;
        }
        return verified;
    }
}
