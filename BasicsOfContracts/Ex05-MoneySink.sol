pragma solidity 0.4.19;
contract MoneySink{
    address owner;
    function() public payable{
        
    }
    function MoneySink() public {
        owner=msg.sender;
    }
    
    function withdraw() public {
        require(owner==msg.sender);
        owner.transfer(this.balance);
    }
}