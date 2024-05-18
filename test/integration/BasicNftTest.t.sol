//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUP =
        "ipfs://bafybeicz57su3zyafexgchnfqej7zuxfa3e4xgz22yzmge6nzkhfmskqs4/";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        //assert(expectedName == actualName);
        //convert strings to bytes
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUP);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUP)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
