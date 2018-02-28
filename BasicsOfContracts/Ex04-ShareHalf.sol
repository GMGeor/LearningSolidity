pragma solidity ^0.4.19;
contract Sharer{
    function sendHalf(address addr) public payable returns (uint balance){
        require(msg.value % 2 == 0);
        uint balanceBeforeTransfer=this.balance;
        assert(this.balance == balanceBeforeTransfer - msg.value/2);
        return this.balance;
    }
}