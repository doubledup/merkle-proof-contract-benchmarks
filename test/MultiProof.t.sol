// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "src/MultiProof.sol";

contract MultiProofTest is Test {
    bytes32 root = 0xe9d2e4ee51fdc67a8a715824c6e0e3dfa013f2fbc17b529ab9787d66b6b1df12;
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
        proof[4][0] = Node({k_index: 1, node: bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e)});
        proof[5] = new Node[](1);
        proof[5][0] = Node({k_index: 1, node: bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede)});
        proof[6] = new Node[](1);
        proof[6][0] = Node({k_index: 1, node: bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44)});
        proof[7] = new Node[](1);
        proof[7][0] = Node({k_index: 1, node: bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2)});
        proof[8] = new Node[](1);
        proof[8][0] = Node({k_index: 1, node: bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c)});
        proof[9] = new Node[](1);
        proof[9][0] = Node({k_index: 1, node: bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c)});
        proof[10] = new Node[](0);

        assert(proofContract.verifyProof(root, proof, leaves));
    }
}
