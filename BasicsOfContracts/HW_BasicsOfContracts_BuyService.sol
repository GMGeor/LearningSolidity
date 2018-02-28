pragma solidity ^0.4.19;
contract Service{
    address owner;
    address seller;
    uint servicesCost;
    uint amountPayedForTheService;
    uint balanceBeforeWithdraw;
    uint change;
    uint lastBoughtAt;
    uint lastWithdrawnAt;
    event Confirms(address indexed from, uint amount);
    event Withdrawn(address indexed to, uint amountWithdrawn);
    
    modifier isAmountEnoughToBuy(uint sendAmount) {
        require(sendAmount>=servicesCost);
        _;
    }
    modifier timeLimitBought(uint _seconds) {
        require(now - lastBoughtAt >= _seconds );
        _;
    }
    modifier timeLimitWithdrawn(uint _seconds) {
        require(now - lastWithdrawnAt >= _seconds );
        _;
    }
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
	}
	
    function Service() public{
        owner=msg.sender;
        servicesCost=1 ether;
        lastBoughtAt=0;
        lastWithdrawnAt=0;
    }
    function BuyService () timeLimitBought(2) isAmountEnoughToBuy(msg.value) public payable {//120
        seller=msg.sender;
        amountPayedForTheService=msg.value;
        change = amountPayedForTheService - servicesCost;
        lastBoughtAt=now;
        if (change>0){
        seller.transfer(change);
        }
        assert(amountPayedForTheService == change + servicesCost);
        Confirms(seller,amountPayedForTheService);
    }
    function WithDrawn (uint _amount) onlyOwner timeLimitWithdrawn(3) public { //3600
        balanceBeforeWithdraw=this.balance;
		require(_amount <= this.balance);
		require(_amount <= 5000000000000000000);
		lastWithdrawnAt=now;
        owner.transfer(_amount);
        assert(this.balance == balanceBeforeWithdraw - _amount);
        Withdrawn(owner, _amount);
    }
    function getBalance() public view returns (uint) {
        return this.balance;
    }
}