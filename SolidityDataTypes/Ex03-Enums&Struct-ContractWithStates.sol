pragma solidity ^0.4.19;
contract contractWith3States{
    address owner;
    enum states{locked, unlocked, restricted}
    states currentState;
    struct dataStructure{
      uint counter;
      uint timeStamp;
      address adr;
    }
    dataStructure public myDataStructure;
    function contractWith3States() public{
        owner=msg.sender;
    }
    modifier OnlyOwner{
        require(owner==msg.sender);
        _;
    }
    modifier CanExecute{
        require(currentState!=states.locked);
        require(currentState==states.unlocked ||
        (currentState==states.restricted && msg.sender==owner));
        _;
    }
    function changeState(states newState) OnlyOwner public{
        currentState=newState;
    }
    function setData() public CanExecute{
        myDataStructure.counter ++;
        myDataStructure.timeStamp=now;
        myDataStructure.adr=msg.sender;
    }
}