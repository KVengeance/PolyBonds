// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract RandomNumber is VRFConsumerBase {
    bytes32 internal keyHash; // identifies which chainlink oracle 
    uint internal fee; // fee to get random number
    uint public randomResult;

    constructor()
        VRFConsumerBase(
            0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B, // VRF Coordinator
            0x01BE23585060835E02B77ef475b0Cc51aA1e0709 // Link Token Address
        ) {
            keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
            fee = 0.1 * 10 ** 18; //0.1 LINK
        }

    function getRandomNumber () public returns (bytes32 requestId){
        require(LINK.balanceOf(address(this)) >=fee, "Not enough Link in contract");
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness (bytes32 requestId, uint randomness) internal override {
        randomResult = randomness;
    }
}