pragma solidity ^0.6.4;
pragma experimental ABIEncoderV2;

contract fmt{

    address public me;
    constructor() public {
        me = msg.sender;
    }

    // convert list of strings into list of bytes32
    function multiStr2bytes(string[] memory strs) public pure returns(bytes32[] memory ret){
        ret = new bytes32[](strs.length);
        for(uint i=0;i<strs.length;i++){
            ret[i] = str2bytes32(strs[i]);
        }
    }

    // convert strings into bytes32
    function str2bytes32(string memory str) public pure returns(bytes32 ret) {
        bytes memory testEmpty = bytes(str);
        if(testEmpty.length==0){
            return 0x0;
        }
        assembly{
            ret := mload(add(str, 32))
        }
    }

    // convert list of bytes32 into list of strings
    function multiBytes322str(bytes32[] memory byts) public pure returns(string[] memory ret){
        ret = new string[](byts.length);
        for(uint i=0;i<byts.length;i++){
            ret[i] = bytes322str(byts[i]);
        }
    }

    // convert bytes32 into string
    function bytes322str(bytes32 byt) public pure returns(string memory ret){
        ret = string(abi.encodePacked(byt));
    }
}