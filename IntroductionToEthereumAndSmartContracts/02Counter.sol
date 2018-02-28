pragma solidity ^0.4.19;

contract Counter{
    
uint256 counter;
    
uint256 count;
    
    
function Counter() public{
        
counter = 0;
        count = 0;
    }
    
function Incrementor(uint256 _incrementWith) public returns(uint256,uint256){
        
count+=_incrementWith;
        
counter++;
        
return (counter, count);
    }
}