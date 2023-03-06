// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "src/SingleProofs.sol";

contract SingleProofsTest is Test {
    bytes32 root = 0xe9d2e4ee51fdc67a8a715824c6e0e3dfa013f2fbc17b529ab9787d66b6b1df12;
    SingleProofs proofContract;

    function setUp() public {
        proofContract = new SingleProofs();
    }

    function testSingleProofs() public view {
        bytes32[] memory leaves = new bytes32[](14);

        leaves[0] = keccak256(abi.encode(bytes32(0x9af1ca5941148eb6a3e9b9c741b69738292c533fa3e9b9c741b69738292c533f)));
        leaves[1] = keccak256(abi.encode(bytes32(0xdd6ca953fdda25c496165d9040f7f77f75b7500296165d9040f7f77f75b75002)));
        leaves[2] = keccak256(abi.encode(bytes32(0x60e9c47b64bc1c7c906e891255eaec19123e7f42906e891255eaec19123e7f42)));
        leaves[3] = keccak256(abi.encode(bytes32(0xfa4859480aa6d899858de54334d2911e01c070df858de54334d2911e01c070df)));
        leaves[4] = keccak256(abi.encode(bytes32(0x19b9b128470584f7209eef65b69f3624549abe6d209eef65b69f3624549abe6d)));
        leaves[5] = keccak256(abi.encode(bytes32(0xc436ac1f261802c4494504a11fc2926c726cb83b494504a11fc2926c726cb83b)));
        leaves[6] = keccak256(abi.encode(bytes32(0xc304c8c2c12522f78ad1e28dd86b9947d7744bd08ad1e28dd86b9947d7744bd0)));
        leaves[7] = keccak256(abi.encode(bytes32(0xda0c2cba6e832e55de89cf4033affc90cc147352de89cf4033affc90cc147352)));
        leaves[8] = keccak256(abi.encode(bytes32(0xf850fd22c96e3501aad4cdcbf38e4aec95622411aad4cdcbf38e4aec95622411)));
        leaves[9] = keccak256(abi.encode(bytes32(0x684918d4387ceb5e7eda969042f036e226e506427eda969042f036e226e50642)));
        leaves[10] = keccak256(abi.encode(bytes32(0x963f0a1bfbb6813c0ac88fcde6ceb96ea634a5950ac88fcde6ceb96ea634a595)));
        leaves[11] = keccak256(abi.encode(bytes32(0x39b38ad74b8bcc5ce564f7a27ac19037a95b6099e564f7a27ac19037a95b6099)));
        leaves[12] = keccak256(abi.encode(bytes32(0xc2dec7fdd1fef3ee95ad88ec8f3cd5bd4065f3c795ad88ec8f3cd5bd4065f3c7)));
        leaves[13] = keccak256(abi.encode(bytes32(0x9e311f05c2b6a43c2ccf16fb2209491babc2ec012ccf16fb2209491babc2ec01)));

        bytes32[][] memory proofs = new bytes32[][](14);

        proofs[0] = new bytes32[](10);
        proofs[0][0] = bytes32(0x49d0965aee46fa69380a2c02506b352ee822c74e201cbc9495e83151e3c860e0);
        proofs[0][1] = bytes32(0x4058afc59ef05692938af1dd47ed764130897bdd630399292dc7caeed3db0f42);
        proofs[0][2] = bytes32(0x3c6a09d9f2d31ed23a393a95f03fd4f6ea0b6a181b8f21d19c9f69117f9ff118);
        proofs[0][3] = bytes32(0x125f3f2840fc2efe872ebc90a12287360b8545bd27a4a531c57383e731bcc8e7);
        proofs[0][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[0][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[0][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[0][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[0][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[0][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[1] = new bytes32[](10);
        proofs[1][0] = bytes32(0xa4d68b3c7521a88352e3dc580363704458b7ee76fc088f24a2855c3cc8d3a295);
        proofs[1][1] = bytes32(0x4058afc59ef05692938af1dd47ed764130897bdd630399292dc7caeed3db0f42);
        proofs[1][2] = bytes32(0x3c6a09d9f2d31ed23a393a95f03fd4f6ea0b6a181b8f21d19c9f69117f9ff118);
        proofs[1][3] = bytes32(0x125f3f2840fc2efe872ebc90a12287360b8545bd27a4a531c57383e731bcc8e7);
        proofs[1][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[1][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[1][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[1][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[1][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[1][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[2] = new bytes32[](10);
        proofs[2][0] = bytes32(0xd981b6b19ba5916486b6c158b43090b96b029ea1309e89a3b81d412f322f9134);
        proofs[2][1] = bytes32(0x22d40b6ffbaf81a4682a24c59e4efc93715d6ee21bddb4d797b91526369c8b3f);
        proofs[2][2] = bytes32(0x3c6a09d9f2d31ed23a393a95f03fd4f6ea0b6a181b8f21d19c9f69117f9ff118);
        proofs[2][3] = bytes32(0x125f3f2840fc2efe872ebc90a12287360b8545bd27a4a531c57383e731bcc8e7);
        proofs[2][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[2][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[2][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[2][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[2][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[2][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[3] = new bytes32[](10);
        proofs[3][0] = bytes32(0x95bd95a9bcbd6db76c73e14ecde47f65d0e17a32cecf8a8213b8fd7a43475df1);
        proofs[3][1] = bytes32(0x22d40b6ffbaf81a4682a24c59e4efc93715d6ee21bddb4d797b91526369c8b3f);
        proofs[3][2] = bytes32(0x3c6a09d9f2d31ed23a393a95f03fd4f6ea0b6a181b8f21d19c9f69117f9ff118);
        proofs[3][3] = bytes32(0x125f3f2840fc2efe872ebc90a12287360b8545bd27a4a531c57383e731bcc8e7);
        proofs[3][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[3][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[3][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[3][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[3][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[3][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[4] = new bytes32[](10);
        proofs[4][0] = bytes32(0x89d1a1a1342e1948c5076dfba6c1eb1e561196ba813a6104c67821f8043e73ce);
        proofs[4][1] = bytes32(0xc310d8433ebd8909ad9b79772b7182cd3c665b197604775a3313e18f9c0de284);
        proofs[4][2] = bytes32(0x98fd9c56f9880786228fad29034978d2c92b3cd7706185dc19cc2175f90e0bb4);
        proofs[4][3] = bytes32(0x125f3f2840fc2efe872ebc90a12287360b8545bd27a4a531c57383e731bcc8e7);
        proofs[4][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[4][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[4][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[4][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[4][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[4][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[5] = new bytes32[](10);
        proofs[5][0] = bytes32(0x073221455b56da427aea047128eb5b1e234f8aee015fc941cb5e534a1919aa56);
        proofs[5][1] = bytes32(0xc310d8433ebd8909ad9b79772b7182cd3c665b197604775a3313e18f9c0de284);
        proofs[5][2] = bytes32(0x98fd9c56f9880786228fad29034978d2c92b3cd7706185dc19cc2175f90e0bb4);
        proofs[5][3] = bytes32(0x125f3f2840fc2efe872ebc90a12287360b8545bd27a4a531c57383e731bcc8e7);
        proofs[5][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[5][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[5][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[5][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[5][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[5][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[6] = new bytes32[](10);
        proofs[6][0] = bytes32(0xde1db3cf55af462edf6c7548b074b00d3972a857ba772e5c72ac8bfce09d0f1c);
        proofs[6][1] = bytes32(0x3c9909f29016d063be8e3596f9a0bff7c133a47ccea7331bc53e33fe2950bdcb);
        proofs[6][2] = bytes32(0x98fd9c56f9880786228fad29034978d2c92b3cd7706185dc19cc2175f90e0bb4);
        proofs[6][3] = bytes32(0x125f3f2840fc2efe872ebc90a12287360b8545bd27a4a531c57383e731bcc8e7);
        proofs[6][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[6][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[6][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[6][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[6][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[6][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[7] = new bytes32[](10);
        proofs[7][0] = bytes32(0x5720e6b63d55f3ba131b05bed6bf333cd435b9ef1d3a3e4c63b7ecd7b8835096);
        proofs[7][1] = bytes32(0x3c9909f29016d063be8e3596f9a0bff7c133a47ccea7331bc53e33fe2950bdcb);
        proofs[7][2] = bytes32(0x98fd9c56f9880786228fad29034978d2c92b3cd7706185dc19cc2175f90e0bb4);
        proofs[7][3] = bytes32(0x125f3f2840fc2efe872ebc90a12287360b8545bd27a4a531c57383e731bcc8e7);
        proofs[7][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[7][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[7][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[7][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[7][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[7][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[8] = new bytes32[](10);
        proofs[8][0] = bytes32(0xcbcf55b80b06c53a94f9fba626d75e137fb6f29876d5577794700d6758fb1c0f);
        proofs[8][1] = bytes32(0xd7bf7713aeb338537de43c85f30c4c32de866fda51913aef6b588aea7ebc27c0);
        proofs[8][2] = bytes32(0xad6d86eb8354c5979352abe57f7ce752582c7b92df37b6107c35173628139f87);
        proofs[8][3] = bytes32(0xd242f57211f5d42f4ab1a6e7d077b257f568d077b75800a3c70962e9dad407fe);
        proofs[8][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[8][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[8][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[8][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[8][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[8][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[9] = new bytes32[](10);
        proofs[9][0] = bytes32(0x092e72f0ccdf86f458b887429da5119a09736268c3b0b3b1cf0b79dd92c49e6c);
        proofs[9][1] = bytes32(0xd7bf7713aeb338537de43c85f30c4c32de866fda51913aef6b588aea7ebc27c0);
        proofs[9][2] = bytes32(0xad6d86eb8354c5979352abe57f7ce752582c7b92df37b6107c35173628139f87);
        proofs[9][3] = bytes32(0xd242f57211f5d42f4ab1a6e7d077b257f568d077b75800a3c70962e9dad407fe);
        proofs[9][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[9][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[9][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[9][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[9][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[9][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[10] = new bytes32[](10);
        proofs[10][0] = bytes32(0x9ad110b4303d41efe1e91ac2e3fb93ee75a4f122271a52a635d9f68bed600067);
        proofs[10][1] = bytes32(0x0efd1b40248f672e0a6c871e6065e8f83fac70c6a2a1298d521e794ed6151cd8);
        proofs[10][2] = bytes32(0xad6d86eb8354c5979352abe57f7ce752582c7b92df37b6107c35173628139f87);
        proofs[10][3] = bytes32(0xd242f57211f5d42f4ab1a6e7d077b257f568d077b75800a3c70962e9dad407fe);
        proofs[10][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[10][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[10][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[10][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[10][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[10][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[11] = new bytes32[](10);
        proofs[11][0] = bytes32(0x766f64d13db14ac977bc5ba2cdad8438dc765b21d47ed2ab63d718c16e3b516a);
        proofs[11][1] = bytes32(0x0efd1b40248f672e0a6c871e6065e8f83fac70c6a2a1298d521e794ed6151cd8);
        proofs[11][2] = bytes32(0xad6d86eb8354c5979352abe57f7ce752582c7b92df37b6107c35173628139f87);
        proofs[11][3] = bytes32(0xd242f57211f5d42f4ab1a6e7d077b257f568d077b75800a3c70962e9dad407fe);
        proofs[11][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[11][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[11][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[11][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[11][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[11][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[12] = new bytes32[](10);
        proofs[12][0] = bytes32(0xb0353b9eae24fbc3359a66376c1a44ba02e6b397fd4e082212b0ecc3e9f1d6e6);
        proofs[12][1] = bytes32(0x38ed1f961a1d2f72ac4db654af8c84045308e926c1cb229e60f8bce9669e231d);
        proofs[12][2] = bytes32(0xcad33986ca309467a8cb360c353d2c954fbb4faf8a65a292a0ab6bf5b7b1b40d);
        proofs[12][3] = bytes32(0xd242f57211f5d42f4ab1a6e7d077b257f568d077b75800a3c70962e9dad407fe);
        proofs[12][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[12][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[12][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[12][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[12][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[12][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        proofs[13] = new bytes32[](10);
        proofs[13][0] = bytes32(0xbe4990fce6e87d94c99392238aa646cbf0576cd20850fb8d4924746c1ed78265);
        proofs[13][1] = bytes32(0x38ed1f961a1d2f72ac4db654af8c84045308e926c1cb229e60f8bce9669e231d);
        proofs[13][2] = bytes32(0xcad33986ca309467a8cb360c353d2c954fbb4faf8a65a292a0ab6bf5b7b1b40d);
        proofs[13][3] = bytes32(0xd242f57211f5d42f4ab1a6e7d077b257f568d077b75800a3c70962e9dad407fe);
        proofs[13][4] = bytes32(0x587ff23491bd611850951f5687cf01abd2f3d1fb7831abae7ce9dfc29a6f840e);
        proofs[13][5] = bytes32(0x59c94a159accf87d0ef183b868a6e63f29e3b8787aa0ca8bcbe0526461f30ede);
        proofs[13][6] = bytes32(0xc66c1da05d80ec9e72cc3bed4e600da7d688c7a7bde6c029749ecd9abe0a0c44);
        proofs[13][7] = bytes32(0x208340fd1b6c076733be0c3cbfa64a05b3202c971e7e15811984f001a7271ad2);
        proofs[13][8] = bytes32(0xf4a3e48c32347d37cb871aaf207fc6a7b5df27b335528b40c8475f859509e39c);
        proofs[13][9] = bytes32(0x1ebd16027005e3ce1351f6d7317c7de195fd135c66a76311c08f84d8205e792c);

        assert(proofContract.verifyProofs(root, proofs, leaves));
    }
}
