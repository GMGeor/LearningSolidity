pragma solidity ^0.4.19;
contract Funding{
    struct HighestBidder{
        address addr;
        uint amount;
    }
    
    HighestBidder public highestBidder;
    function Funding() public {
        //initialize with (order should be as in struct declaration)
        highestBidder=HighestBidder(msg.sender,0);
        //or (order doesn't matter)
        highestBidder=HighestBidder({addr:msg.sender, amount:0});
        //or (but more costly)
        highestBidder.addr=msg.sender;
        highestBidder.amount=0;
    }
    function bid() public payable{
        if(msg.value>highestBidder.amount){
            highestBidder=HighestBidder(msg.sender,msg.value);
        }
    }
}