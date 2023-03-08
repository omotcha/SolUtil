pragma solidity ^0.6.4;
pragma experimental ABIEncoderV2;

contract fmt{
    address public me;
    constructor() public {
        me = msg.sender;
    }

    function multiStr2bytes(string[] memory strs) public pure returns(bytes32[] memory ret){
        ret = new bytes32[](strs.length);
        for(uint i=0;i<strs.length;i++){
            ret[i] = str2bytes32(strs[i]);
        }
    }

    function str2bytes32(string memory str) public pure returns(bytes32 ret) {
        assembly{
            ret := mload(add(str, 32))
        }
    }
}