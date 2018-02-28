pragma solidity ^0.4.0;
contract Service {
    address owner;
    uint lastPurchase;
    uint lastWithDraw;
    
    modifier canBuy {
        require((now - lastPurchase) >= 2 minutes);
        lastPurchase = now;
        _;
    }
    
    modifier canWithdraw {
        require((now - lastWithDraw) >= 1 hours);
        lastWithDraw = now;
        _;
    }

    modifier isOwner {
      require(msg.sender == owner);
      _;
    }
    
    event ServiceBought(address boughtBy);

    function Service() public {
        owner = msg.sender;
        lastPurchase = 0;
        lastWithDraw = 0;
    }
    
    function() public payable canBuy {
        require(msg.value >= 1 ether);
        
        if(msg.value > 1 ether) {
            msg.sender.transfer(msg.value - 1 ether);
        }
        
        ServiceBought(msg.sender);
    }
    
    function withdraw() public isOwner canWithdraw returns (uint) {
        require(this.balance > 0);
        
        uint amount = (this.balance > 5 ether) ? 5 ether : this.balance;
        msg.sender.transfer(amount);
        
        return amount;
    }
}