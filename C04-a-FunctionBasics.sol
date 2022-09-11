pragma solidity ^0.6.10;

/* 함수의 형식, 리턴 값, 배열 인자의 call-by-value */
contract FunctionBasics {
    uint[] public arrayA = [1, 2];
    uint[] public arrayB;
    uint[] public arrayC = [3, 4];
    uint[] public arrayD;
    
    uint public returnValue1;
    bool public returnValue2;
    uint public returnValue3;
     
    function returnNamed() public returns (uint x, bool b, uint y) { // 여러개의 리턴 값 가능
        return (3, false, 4);
    }
   
    function returnUnnamed() public returns (uint, bool, uint) { // 리턴 값들의 이름 생략 가능 (x, b, y)
        return (1, true, 2);
    }    
       
    function returnAssigned() public returns (uint x, bool b, uint y) { // 리턴 값들의 이름을 직접 사용, return 은 생략가능
        x = 5;
        b = true;
        y = 6;
    }

    //------------------------------------------

    function returnAssign() public { // 여러개의 리턴 값을 받는 방법
        (uint i, bool b, uint j) = returnNamed();
        (returnValue1, returnValue2, returnValue3) = returnNamed();
    }
    
    function testArray() public { // 함수 인자와 리턴 값으로 배열을 사용
        callWithArray(arrayA);	  // call-by-value, 메모리에 값이 복사됨
        arrayD = returnArray();
    }

    function callWithArray(uint[] memory _array) internal {
        arrayB = _array;  // call-by-value, 메모리에 값이 복사됨
        _array[0] = 1000; // 인자값을 변경(대입)해도 arrayB는 변경되지 않음
    }

    function returnArray() public returns (uint[] memory) {	// 배열을 리턴할 수 있음
        return arrayC;
    }
}