// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "solidity-merkle-trees/MerkleMultiProof.sol";

contract MultiProof {
    function verifyProof(bytes32 root, Node[][] memory proof, Node[] memory leaves)
        public
        pure
        returns (bool)
    {
        return MerkleMultiProof.verifyProof(root, proof, leaves);
    }
}
