pragma solidity 0.4.19;
contract ex2{
    address owner;
    event changesInTheOwnership(address indexed oldOwner, address indexed newOwner);
    }
    function ex2(){
        owner=msg.sender;
    }
    function hwoIsTheOwner()returns(address){
        return owner;
    }
    function chnageTheOwner(address newOwner)  {
        if(owner==msg.sender){
            changesInTheOwnership(owner,newOwner);
            owner=newOwner;
        }
    }
}