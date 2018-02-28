pragma solidity ^0.4.19;
contract test{
    enum ActionChoices{GoLeft, GoRight,GoStraight,SitStill}
    ActionChoices choice;
    ActionChoices constant defaulthChoice=ActionChoices.GoStraight;
    
    function setGoStraight() public{
        choice=ActionChoices.GoStraight;
    } 
    function getChoice() public view returns (ActionChoices){
        return choice;
    }
    
    function getDefaulthChoice() public pure  returns (uint){
        return uint (defaulthChoice);
    }
}