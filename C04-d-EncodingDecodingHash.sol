pragma solidity ^0.6.10;

/* ABI 인코딩과 디코딩 */
contract ABIEncodeDecode
{
    string public encodedString;
    string public encodedPackedString;
    
    uint public decodedUint;
    string public decodedString;
    
    function encode(uint a, string memory b) public returns(string memory)
    {
        encodedString = string(abi.encode(a, b)); 
        // 정수와 문자열을 합쳐서 인코딩 👉 bytes 리턴 👉 string으로 형변환
        return string(abi.encode(a, b)); 
        // bytes 자료형으로 인코딩된 데이터를 문자열로 변환하여 리턴
    }
    
    function encodePacked(uint a, string memory b) public returns(string memory)
    {
        encodedPackedString = string(abi.encodePacked(a, b));	
        // 정수와 문자열을 합쳐서 인코딩 (축약형) 👉 표준은 아님
        // encodePacked은 주로 저장 공간(용량)을 줄이는 목적이다
        // ⭐ 표준이 아니라 디코딩은 안된다
        return string(abi.encodePacked(a, b));			        
        // bytes 자료형으로 인코딩된 데이터를 문자열로 변환하여 리턴
    }
    
    function decode(string memory a) public pure returns(uint, string memory)
    {
        return abi.decode(bytes(a), (uint, string));			
        // 인코딩된 abi 데이터를 👉 원본으로 디코딩, 정수와 문자열을 리턴
    }

    function testEncodeDecode() public {
        uint a = 123;
        string memory b = "ABC";
        string memory encoded;
        string memory encodedPacked;
        
        encoded = encode(a, b);
        encodedPacked = encodePacked(a, b);             
        
        // (decodedUint, decodedString) = decode(encodedPacked); 
        // 👉 encodePacked로 인코딩된 데이터는 디코딩 안됨 (표준이 아니기때문)
        (decodedUint, decodedString) = decode(encoded);
    }    
}

/* 해쉬 함수 keccak */
contract HashFunction {
    bytes32 public hashVal1;
    bytes32 public hashVal2;
    bool public isIdentical;
    
    function hashData1() public {
        string memory text1 = "ABC";
        string memory text2 = "DEF";
        
        hashVal1 = keccak256(abi.encodePacked(text1, text2));	
        // 두 개의 문자열을 합쳐서 keccak 해쉬 적용 
        // 👉 결과는 32바이트 (bytes32)
    }
    
    function hashData2() public {
        string memory text1 = "AB";
        string memory text2 = "CDEF";
        
        hashVal2 = keccak256(abi.encodePacked(text1, text2));	
        // 두 개의 문자열을 합쳐서 keccak 해쉬 적용, 
        // 👉 결과는 32 바이트 bytes32
    }

    function testCollision() public {	
        if (hashVal1 == hashVal2)				                
        // bytes32 자료형간에는 직접 비교 가능
            isIdentical = true; // 👉 결과는 일치
    } // "ABC" + "DEF" 인코딩 👉 ABCDEF
      // "AB" + "CDEF" 인코딩 👉 ABCDEF
      // 인코딩하면 결과가 같다 
}

/* 컨트랙트 실행을 통한 확인
(1) 컨트랙트 배포: ABIEncodeDecode, HashFunction 
(2) ABIEncodeDecode 컨트랙트 실행
    (2-1) testEncodeDecode( ) 실행 --> encode(123, "ABC")
    (2-2) decodedUint 및 decodedString 값 확인: 123, ABC
(3) HashFunction 컨트랙트 실행
    (3-1) hashData1( ) 실행 --> keccak256(abi.encodePacked("ABC", "EDF"))
    (3-2) hashData2( ) 실행 --> keccak256(abi.encodePacked("AB", "CEDF"))
    (3-3) testCollision( ) 실행, isIdentical 값 확인: true
*/

// -------------------------------------------

// “C04-d-EncodingDecodingHash.sol” 파일에서 HashFunction 컨트랙트의 hashData2의 함수를 
// text1과 text2에 각각 “”과 “ABCDEF”를 할당하도록 수정하시오. 

// 수정된 컨트랙트에서 hashData1, hashData2, testCollision 함수를 
// 순서대로 실행하면 isIdentical 값은 얼마가 되는가?
// 👉 true

contract HashFunction2 {
    bytes32 public hashVal1;
    bytes32 public hashVal2;
    bool public isIdentical;
    
    function hashData1() public {
        string memory text1 = "ABC";
        string memory text2 = "DEF";
        
        hashVal1 = keccak256(abi.encodePacked(text1, text2));	
        // 두 개의 문자열을 합쳐서 keccak 해쉬 적용 
        // 👉 결과는 32바이트 (bytes32)
    }
    
    function hashData2() public {
        string memory text1 = "";
        string memory text2 = "ABCDEF";
        
        hashVal2 = keccak256(abi.encodePacked(text1, text2));	
        // 두 개의 문자열을 합쳐서 keccak 해쉬 적용, 
        // 👉 결과는 32 바이트 bytes32
    }

    function testCollision() public {	
        if (hashVal1 == hashVal2)				                
        // bytes32 자료형간에는 직접 비교 가능
            isIdentical = true; // 👉 결과는 일치
    } // "ABC" + "DEF" 인코딩 👉 ABCDEF
      // "" + "ABCDEF" 인코딩 👉 ABCDEF
      // 인코딩하면 결과가 같다 
}