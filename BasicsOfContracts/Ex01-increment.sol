pragma solidity 0.4.19;
contract ex1{
    uint state;
    uint lastIncrement;
    address owner;
    
    function ex1(uint _state){
        owner = msg.sender;
        lastIncrement=0;
        state = _state;
    }
    function increment() returns (uint){
        if (msg.sender==owner && (now - lastIncrement >= 15 seconds))
        {
            state++;
            lastIncrement=now;
        }
        return state;
    }
}