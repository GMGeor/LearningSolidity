pragma solidity ^0.4.19;

contract Faucet{

    address owner;
    uint sendAmount;

    event Transfer(address indexed from, address indexed to, uint ethers);

    function() public payable { //fallback function called when ETH is sent

    }

    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }

    modifier sendAmountCondition() {
        require(sendAmount <= this.balance);
        _;
    }

    function Faucet() public{
        owner = msg.sender;
        sendAmount = 1 ether;
    }

    function changeValueOfSendAmount(uint newSendAmount) onlyOwner public{
        sendAmount = newSendAmount;
    }

    function withdrawSendAmount() sendAmountCondition public{
        uint balanceBeforeTransfer=this.balance;
        msg.sender.transfer(sendAmount);
        assert(this.balance == balanceBeforeTransfer + sendAmount);
        Transfer(msg.sender, msg.sender, sendAmount);
    }

    function sendSendAmount(address someoneElse) sendAmountCondition public {
        someoneElse.transfer(sendAmount);
        Transfer(msg.sender, someoneElse, sendAmount);
    }

    function ownerWithdraw(uint amount) onlyOwner public{
        require(amount <= this.balance);
        owner.transfer(amount);
        Transfer(owner, owner, amount);
    }

    function getBalance() public view returns (uint) {
        return this.balance;
    }

    function destruction() onlyOwner public{
        selfdestruct(owner);
    }

} 