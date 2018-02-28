pragma solidity ^0.4.19;
contract Calculator{
    int128 number1;
    int128 number2;
    function Calculator() public{
        number1=0;
        number2=0;
    }
    function Add(int128 _number1, int128 _number2) public returns (int256){
        return _number1+_number2;
    }
    function Substract(int128 _number1, int128 _number2) public returns (int256){
        return _number1-number2;
    }
    function Multiply(int128 _number1, int128 _number2) public returns (int256){
        return _number1*number2;
    }
    function Divide(int128 _number1, int128 _number2) public returns (int256){
        if  (_number2==0){
            return 0;
        }
        return _number1/_number2;
    }
    function Raise(uint128 _number1, uint128 _number2) public returns (uint256){
        if (_number1**_number2>2**200){
            return 0;
        }
        return _number1**_number2;
    }
    function Remainder(int128 numerator, int128 denominator) public returns(int128){
        int128 quotient;
        int128 remainder;
        quotient  = numerator / denominator;
        remainder = numerator - denominator * quotient;
        return remainder;
    }
    
}