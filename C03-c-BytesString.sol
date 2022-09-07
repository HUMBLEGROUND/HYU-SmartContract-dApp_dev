pragma solidity ^0.6.4;

/* 바이트 배열(bytes) 및 문자열(string)의 문법적 성질 */
// [3주차]솔리더티 문법 1 (변수 유형과 자료형)

contract BytesString {
    
    bytes public bytesVal1;
    bytes public bytesVal2;
    bytes public bytesVal3;
    string public stringVal1;
    string public stringVal2;
    string public stringVal3;
    
    bool public isTrue1;
    bool public isTrue2;
    uint public length;
    
    function testBytesString() public returns (bool) {
        bytesVal1 = "AB";
        bytesVal2 = "AC";
        stringVal1 = "AB";
        stringVal2 = "AC";
        bytes32 bytes32Val1 = "XY";
        bytes32 bytes32Val2 = "XY";
        
        
        bytesVal3 = bytes(stringVal2);              // "문자열(string) --> 바이트열(bytes)" 형변환 가능
        stringVal3 = string(bytesVal2);             // "바이트열(bytes) --> 문자열(string)" 형변환 가능
        
        if (bytes32Val1[0] == bytes32Val2[0])       // bytes32 자료형은 인덱스(index)를 이용한 접근 가능
            isTrue2 = true;
         
        if (bytesVal1[0] == bytesVal2[0])		    // 바이트열(bytes)은 인덱스(index)를 이용한 접근 가능
            isTrue1 = true;
        
        // if (stringVal1[0] == stringVal2[0])      // 문자열(string)은 인덱스(index)를 이용한 접근 "불가능"
            // isTrue1 = true;
        
        length = bytes32Val1.length;		        // bytes32 자료형은 길이(length)를 멤버로 가짐  
        length = bytesVal1.length;		            // 바이트열(bytes)은 길이(length)를 멤버로 가짐
        // length = stringVal1.length;              // 문자열(string)은 길이(length)를 멤버로 "가지지 않음"
       
        if (bytes32Val1 == bytes32Val2)             // bytes32 자료형간에는 "직접 비교 가능"
            return true;
        
        // if (bytesVal1 == bytesVal2)              // 바이트열(bytes) 자료형간에는 직접 비교 "불가능"
            // return true;
        
        // if (stringVal1 == stringVal2)            // 문자열(string) 자료형간에는 직접 비교 "불가능"
            // return true;
    }
}