pragma solidity 0.4.19;
contract ex2{
    address owner;
    event changesInTheOwnership(address indexed oldOwner, address indexed newOwner);
    modifier OnlyOwner{
        require(msg.sender==owner);
        _;  
    }
    function ex2(){
        owner=msg.sender;
    }
    function hwoIsTheOwner()returns(address){
        return owner;
    }
    function chnageTheOwner(address newOwner) OnlyOwner {
            changesInTheOwnership(owner,newOwner);
            owner=newOwner;
        }
    }
}