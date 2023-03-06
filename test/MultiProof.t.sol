// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "src/MultiProof.sol";

contract MultiProofTest is Test {
    bytes32 root = 0xe3bed918d1f4dd365a6750611fa0396df1313e58dc71c9294f5e6e2e61064479;
    MultiProof proofContract;

    function setUp() public {
        proofContract = new MultiProof();
    }

    function testMultiProofs() public view {
        Node[] memory leaves = new Node[](14);
        leaves[0] = Node({k_index: 0, node: keccak256(abi.encode(bytes32(0x9af1ca5941148eb6a3e9b9c741b69738292c533fa3e9b9c741b69738292c533f)))});
        leaves[1] = Node({k_index: 1, node: keccak256(abi.encode(bytes32(0xdd6ca953fdda25c496165d9040f7f77f75b7500296165d9040f7f77f75b75002)))});
        leaves[2] = Node({k_index: 2, node: keccak256(abi.encode(bytes32(0x60e9c47b64bc1c7c906e891255eaec19123e7f42906e891255eaec19123e7f42)))});
        leaves[3] = Node({k_index: 3, node: keccak256(abi.encode(bytes32(0xfa4859480aa6d899858de54334d2911e01c070df858de54334d2911e01c070df)))});
        leaves[4] = Node({k_index: 4, node: keccak256(abi.encode(bytes32(0x19b9b128470584f7209eef65b69f3624549abe6d209eef65b69f3624549abe6d)))});
        leaves[5] = Node({k_index: 5, node: keccak256(abi.encode(bytes32(0xc436ac1f261802c4494504a11fc2926c726cb83b494504a11fc2926c726cb83b)))});
        leaves[6] = Node({k_index: 6, node: keccak256(abi.encode(bytes32(0xc304c8c2c12522f78ad1e28dd86b9947d7744bd08ad1e28dd86b9947d7744bd0)))});
        leaves[7] = Node({k_index: 7, node: keccak256(abi.encode(bytes32(0xda0c2cba6e832e55de89cf4033affc90cc147352de89cf4033affc90cc147352)))});
        leaves[8] = Node({k_index: 8, node: keccak256(abi.encode(bytes32(0xf850fd22c96e3501aad4cdcbf38e4aec95622411aad4cdcbf38e4aec95622411)))});
        leaves[9] = Node({k_index: 9, node: keccak256(abi.encode(bytes32(0x684918d4387ceb5e7eda969042f036e226e506427eda969042f036e226e50642)))});
        leaves[10] = Node({k_index: 10, node: keccak256(abi.encode(bytes32(0x963f0a1bfbb6813c0ac88fcde6ceb96ea634a5950ac88fcde6ceb96ea634a595)))});
        leaves[11] = Node({k_index: 11, node: keccak256(abi.encode(bytes32(0x39b38ad74b8bcc5ce564f7a27ac19037a95b6099e564f7a27ac19037a95b6099)))});
        leaves[12] = Node({k_index: 12, node: keccak256(abi.encode(bytes32(0xc2dec7fdd1fef3ee95ad88ec8f3cd5bd4065f3c795ad88ec8f3cd5bd4065f3c7)))});
        leaves[13] = Node({k_index: 13, node: keccak256(abi.encode(bytes32(0x9e311f05c2b6a43c2ccf16fb2209491babc2ec012ccf16fb2209491babc2ec01)))});

        Node[][] memory proof = new Node[][](11);
        proof[0] = new Node[](0);
        proof[1] = new Node[](1);
        proof[1][0] = Node({k_index: 7, node: bytes32(0x38ed1f961a1d2f72ac4db654af8c84045308e926c1cb229e60f8bce9669e231d)});
        proof[2] = new Node[](0);
        proof[3] = new Node[](0);
        proof[4] = new Node[](1);
        proof[4][0] = Node({k_index: 1, node: bytes32(0x4af8884809dc528c832c9fea1be84c0c5209277b91293d24f717b88801e9e181)});
        proof[5] = new Node[](1);
        proof[5][0] = Node({k_index: 1, node: bytes32(0x253f7b20fcd44e426a7c191e9cf89abcb514d0b480a987a052f8d9d1f3715d72)});
        proof[6] = new Node[](1);
        proof[6][0] = Node({k_index: 1, node: bytes32(0x595d11848f09575dfbbf6bfe2b917956d15d3239addc3a651b90058762c348bb)});
        proof[7] = new Node[](1);
        proof[7][0] = Node({k_index: 1, node: bytes32(0xbb0bc2cb5fbe4de1d0e58c37003a9e2967020d4456ec66de0115c7298d4b9ce6)});
        proof[8] = new Node[](1);
        proof[8][0] = Node({k_index: 1, node: bytes32(0x8376f950dd4eff30a311512e06d1b01e59bcc7098f15433752021f5cc1bbfa8f)});
        proof[9] = new Node[](1);
        proof[9][0] = Node({k_index: 1, node: bytes32(0x1d375245de36bf8a22d4cc1fb487925dc486517474eea65cb0a82d265b33d0c2)});
        proof[10] = new Node[](0);

        assert(proofContract.verifyProof(root, proof, leaves));
    }
}
