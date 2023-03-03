// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "solidity-merkle-trees/MerkleMultiProof.sol";

contract MultiProofsTest is Test {
    bytes32 root = 0x9bc0c8d73b07d734720fa43b6849ef1cdab2565b48e3705473587da87b055ea6;

    function testMultiProofs() public view {
        Node[] memory leaves = new Node[](3);
        leaves[0] = Node({k_index: 3, node: keccak256(abi.encode(bytes32(0xfa4859480aa6d899858de54334d2911e01c070df858de54334d2911e01c070df)))});
        leaves[1] = Node({k_index: 57, node: keccak256(abi.encode(bytes32(0x355069da35e598913d8736e5b8340527099960b83d8736e5b8340527099960b8)))});
        leaves[2] = Node({k_index: 134, node: keccak256(abi.encode(bytes32(0x7663893c3dc0850efc5391f5e5887ed723e51b83fc5391f5e5887ed723e51b83)))});

        Node[][] memory proof = new Node[][](9);
        proof[0] = new Node[](3);
        proof[0][0] = Node({k_index: 2, node: bytes32(0x95bd95a9bcbd6db76c73e14ecde47f65d0e17a32cecf8a8213b8fd7a43475df1)});
        proof[0][1] = Node({k_index: 56, node: bytes32(0xc246afd9bc6291ecc63bc55d86862031880bd8f7371c7577b327d0b477727961)});
        proof[0][2] = Node({k_index: 135, node: bytes32(0xcc22ffc806c4d549da4e6309999bcdb4d08ec808d20a288b0106f4f70ec75940)});
        proof[1] = new Node[](3);
        proof[1][0] = Node({k_index: 0, node: bytes32(0x22d40b6ffbaf81a4682a24c59e4efc93715d6ee21bddb4d797b91526369c8b3f)});
        proof[1][1] = Node({k_index: 29, node: bytes32(0xa7493a81931ff691585c92cd84fefebda1636e148148af5da4cc1ca849c9d562)});
        proof[1][2] = Node({k_index: 66, node: bytes32(0x010f5d2275f3a2226d2f2d795e816c6fe9b14e8d397315bb292943958824568d)});
        proof[2] = new Node[](3);
        proof[2][0] = Node({k_index: 1, node: bytes32(0x3c6a09d9f2d31ed23a393a95f03fd4f6ea0b6a181b8f21d19c9f69117f9ff118)});
        proof[2][1] = Node({k_index: 15, node: bytes32(0xc64e868704a6646b88e87424c08d926af3d92a698069a568a508fc3a4074297a)});
        proof[2][2] = Node({k_index: 32, node: bytes32(0x90880c80c8dc3b03ce49f7306352b5bf78dc2a1e3e7fb80662d25632ba23e0b7)});
        proof[3] = new Node[](3);
        proof[3][0] = Node({k_index: 1, node: bytes32(0x125f3f2840fc2efe872ebc90a12287360b8545bd27a4a531c57383e731bcc8e7)});
        proof[3][1] = Node({k_index: 6, node: bytes32(0x5621c6d3424cf441777599cfb23c8b7dd8b5956894603d5df15f7376b11317e4)});
        proof[3][2] = Node({k_index: 17, node: bytes32(0x78e04f9a45dc62c109c07687b06f1c49578bb32a75e56c0a74acfb02878aac1a)});
        proof[4] = new Node[](3);
        proof[4][0] = Node({k_index: 1, node: bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e)});
        proof[4][1] = Node({k_index: 2, node: bytes32(0xef089e23836b13724883695a231104ac9c5e0412dddd413a98b2feddf89e7481)});
        proof[4][2] = Node({k_index: 9, node: bytes32(0xd288ecce4e19cd7bd34ab40b9df0a430e3f919236a2b9bd809bcd81d41635f4f)});
        proof[5] = new Node[](1);
        proof[5][0] = Node({k_index: 5, node: bytes32(0x49d1ccb745f659094dec225df880fba864ae99e5082ae7a3d417da511ba5c2f3)});
        proof[6] = new Node[](1);
        proof[6][0] = Node({k_index: 1, node: bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44)});
        proof[7] = new Node[](0);
        proof[8] = new Node[](0);

        assert(MerkleMultiProof.verifyProof(root, proof, leaves));
    }
}
