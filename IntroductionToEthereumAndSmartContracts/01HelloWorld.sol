pragma solidity ^0.4.19;

contract Greeting {
    
string greet;
    
function  Greeting(string _greet) public{

        greet = _greet;
    }
    
function greeting() public returns (string) {
 
    return greet;   
    }
}