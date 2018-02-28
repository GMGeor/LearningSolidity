pragma solidity ^0.4.19;
//I Have no much developer experience. Below code is attempting to solve some issues such as overflows, but with no luck..
contract Homework1{
    int256 public number1;
    int256 public number2;
    function Homework1(int256 _number2){
        number1=0;
        number2=_number2;
    }
    function Add(int256 _number2) public returns (int256){
         if  (number1+_number2>2**200){
            return number1;
        } 
        number1+=_number2;
        return number1;
    }
    function Substract(int256 _number2) public returns (int256){
        number1-=_number2;
        return number1;
    }
    function Multiply(int256 _number2) public returns (int256){
        if  (number1*_number2>2**200){
            return number1;
        } 
        number1*=_number2;
        return number1;
    }
    function Divide(int256 _number2) public returns (int256){
        if  (_number2==0){
            return 0;
        }
        number1/=_number2;
        return number1;
    }
    function Raise(uint256 _number2) public returns (int256){
        uint256 numbertmp;
        numbertmp = uint256(number1);
        if  (numbertmp**_number2>2**200){
            return number1;
        } 
        numbertmp = numbertmp**_number2;
        number1=int256(numbertmp);
        return number1;
    }
    function Remainder(int256 _number2) public returns(int256){
        int256 quotient;
        quotient  = number1 / _number2;
        number1 = number1 - _number2 * quotient;
        return number1;
    }
    function GetStateNum1() constant returns (int256 _stateVar) {
        _stateVar = number1;
    }
    function ResetStateNum1() public returns (int256 _stateVar) {
        number1 = 0;
        _stateVar = number1;
    }

}