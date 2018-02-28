pragma solidity ^0.4.19;
contract PeopleBalances{
    address owner;
    uint startCrowdSale;
    mapping(address => uint) public balances;
    mapping(address => bool) public tokenHolder; //ever
    address[] public tokenHolders;
    
    function PeopleBalances() public{
        owner=msg.sender;
        startCrowdSale=now;
    }
    
    modifier OnlyOwner(){
        require(msg.sender==owner);
        _;
    }
    
    modifier CrowdSalePeriod(){
        require(now-startCrowdSale<=5 minutes);
        _;
    }
    
    modifier OpenSalePeriod(){
        require(now- startCrowdSale >= 5 minutes);
        _;
    }
    
    event BuyEvent(address indexed from, uint amount);
    event SellEvent(address indexed from, address indexed to, uint amount);
    event WithdrawnEvent(address indexed to, uint amountWithdrawn, uint when);
    
    function CrowdSales_Buy() CrowdSalePeriod public payable{
        uint tokensToBuy=msg.value/5;
        uint balanceBefore=balances[msg.sender];
        require(msg.sender.balance>=tokensToBuy*5);
        balances[msg.sender] += tokensToBuy;
        tokenHolder[msg.sender] = true;
        assert(balanceBefore==balances[msg.sender]-tokensToBuy);
        BuyEvent(msg.sender, tokensToBuy);
        
        bool duplicate = false;
        for(uint i =0; i<tokenHolders.length;i++ ){
            if(tokenHolders[i]==msg.sender){
                duplicate=true;
                break;
            }
        }
        if(duplicate == false){
            tokenHolders.push(msg.sender);
        }
        
    }
    function OpenSales_Sell(address BuyerAdr, uint amount) OpenSalePeriod public{
        uint buyerBalanceBeforeTx = balances[BuyerAdr];
        uint sellerBalanceBeforeTx = balances[msg.sender];
        require(balances[msg.sender]>=amount);
        balances[msg.sender]-=amount;
        balances[BuyerAdr]+=amount;
        assert(buyerBalanceBeforeTx+amount==balances[BuyerAdr]);
        assert(sellerBalanceBeforeTx-amount==balances[msg.sender]);
        
        SellEvent(msg.sender, BuyerAdr, amount);
        
        bool duplicate=false;
        for(uint i =0; i<tokenHolders.length;i++){
            if(tokenHolders[i]==BuyerAdr){
                duplicate=true;
                break;
            }
        }
        if(duplicate==false){
            tokenHolders.push(BuyerAdr);
            tokenHolder[BuyerAdr]=true;
        }
        if(balances[BuyerAdr]==0){
            tokenHolder[BuyerAdr]=false;
        }
        //if only current holders should be kept:
        //if(balances[msg.sender]==0){
        //    tokenHolder[msg.sender]=false;
        //}
    
    }
    
    function withDraw(uint _amount) OnlyOwner public{
        require(now - startCrowdSale>= 1 minutes);
        require(this.balance>=_amount);
        owner.transfer(_amount);
        WithdrawnEvent(owner, _amount, now);
    }
    
    function getAllHolders() public view returns(address[]){
        return tokenHolders;
    }
    
    function getBalance() OnlyOwner public view returns (uint) {
        return this.balance;
    }
    
}