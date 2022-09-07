pragma solidity ^0.6.4;

/* 밸류형과 참조형 변수의 문법적 성질 */
// [3주차]솔리더티 문법 1 (변수 유형과 자료형)

/* 밸류형 변수 */
contract ValueTypeVariables { // value type의 변수의 문법
    /* 부울형(bool) */
    bool booVar1 = true;                        		// 상태변수의 default visibility는 internal, 컨트랙트 내부 및 자식 클래스에서 접근 가능
    bool private boolVar2 = true;               		// private variable, 자식 클래스에서 접근 불가능
    bool public boolVar3;                       		// public variable, 초기값이 없을 경우 'zero state' 또는 'false'로 초기화
    
    /* 부호없는 정수형(uint) */
    uint8 public uint8Var = uint8(0) - uint8(1);		// 8-bit 부호가 없는 정수, "0 - 1"은 underflow로 인해 255가 됨
    uint256 public uint256Var = 2**256 - 1;		        // 256-bit 부호가 없는 정수, 최대값은 "2**256 - 1"
    uint public uintVar = 2**256 - 1;			        // uint와 uint256은 동일한 자료형

    /* 부호있는 정수형(int) */    
    int8 public int8Var = 32;				            // 8-bit 부호가 있는 정수
    int256 public int256Var = 2**255 - 1;		        // 256-bit 부호가 있는 정수, 1-bit를 부호로 사용, 최대값은 "2**255 - 1"
    int public intVar = - 2**255;			            // int와 int256은 동일한 자료형
    
    /* 열거형(enum) */
    enum MyEnum {				                        // 열거형, 각 심볼은 순서대로 0, 1, 2, 3, 4, ...로 취급
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    
    MyEnum public enumVar1 = MyEnum.Accepted;	        // 열거형 항목 참조는 '.' 사용
    MyEnum public enumVar2 = MyEnum(4);		            // 열거형 항목 대신 숫자 사용 가능 (형변환 필요)

    /* 주소형(address) */
    address public owner;				                // 주소형 (20 바이트)
    
    constructor() public {
        // uint public xx;                              // 지역변수에 대해서는 가시성(visisbility) 지정 불가 
        owner = msg.sender;				                
    }
}

/* 참조형 변수: 배열, 구조체, 매핑 */
contract ReferenceTypeVariables {
    /* 정수 배열(array) */
    uint[2] public arrayVar1 = [1, 2];			        // 고정크기(fixed-size) 배열, 초기화는 [ ] 사용
    uint[] public arrayVar2;				            // 동적크기(dynamically-sized) 배열
    
    /* 문자열(string) */
    string public stringVar = "Hello World";	        // 문자열

    /* 구조체(struct) */
    struct MyStruct {				                    // 구조체
        uint val;	                    
        bool ok;		                        
    }
    
    MyStruct public structVar1 = MyStruct(4, true);		            // 구조체 초기화 방법 1
    MyStruct public structVar2 = MyStruct({val:5, ok:true});	    // 구조체 초기화 방법 2
    
    /* 매핑(mapping) */
    mapping (uint => string) public mappingVar1;			        // 매핑형, "mappinVar1[uint] = string" 형식으로 사용
    mapping (uint => mapping (bool => string)) public mappingVar2;	// 매핑형, "mappinVar2[uint][bool] = string" 형식으로 사용
    // 매핑 안에 매핑
        
    constructor() public {
        arrayVar2 = [3, 4, 5];				            // 동적크기(dynamically-sized) 배열의 초기화
        arrayVar2.push(6);				                // 배열의 멤버함수 push, 배열 맨 뒤에 항목 추가
        arrayVar2.pop();				                // 배열의 멤버함수 pop, 배열 맨 뒤의 항목 제거
		
        mappingVar1[0] = "The 1st mapping value";	                // 매핑형, mappinVar1[uint] = string 형태로 사용
        mappingVar1[1] = "The 2nd mapping value";	                // 매핑형, mappinVar1[uint] = string 형태로 사용
        mappingVar2[0][false] = "The 1st mapping of mapping";	    // 매핑형, mappinVar2[uint][bool] = string 형태로 사용
        mappingVar2[0][true] = "The 2nd mapping of mapping";	    // 매핑형, mappinVar2[uint][bool] = string 형태로 사용
    }
}