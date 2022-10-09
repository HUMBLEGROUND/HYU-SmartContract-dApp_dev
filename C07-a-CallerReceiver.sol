pragma solidity ^0.6.4;

/* 외부 컨트랙트 함수의 호출 */

contract Receiver {
    uint public stateVal;
    
    fallback() external payable {
        stateVal = 1;
    }
    
    function foo(uint x) public returns (uint) {
        stateVal = x + 5;
        return stateVal;
    }
}

/* 컨트랙트 이름 또는 주소를 이용하는 외부 컨트랙트 호출 */
contract Caller {
    Receiver public ReceiverA;					                // ReceiverA의 참조만 생성, 객체는 생성되지 않음
    Receiver public ReceiverB = new Receiver();				    // ReceiverB의 객체 생성 (Caller에 포함되어 함께 배포됨, Callee는 별도 배포 필요없음)
    uint public returnVal;
    
    function callFooA() public {
        ReceiverA.foo(123);						                // ReceiverA의 객체가 존재하지 않으므로 호출 실패
    }
    
    function callFooB() public {
        ReceiverB.foo(456);						                // 컨트랙트 이름을 이용한 호출 --> 성공
    }
    
    function callFooWithAddr(address payable addr) public {		// payable 함수를 가지는 CA의 주소를 변환하려면 address payable로 설정
        Receiver receiver = Receiver(addr);				
        receiver.foo(789);						                // 변환된 컨트랙트를 이용한 호출 --> 성공: xyz = 789
    }
    
    function callFooLowLevel(address addr) public {
        (bool success, bytes memory data) = addr.call(			// 주소를 사용하여 call 함수로 호출 --> 성공: xyz = 999
            abi.encodeWithSignature("foo(uint256)", 999));		// 함수의 시그니처와 파라미터를 함께 인코딩하여 하나의 bytes형 파라미터로 변환
        returnVal = abi.decode(data, (uint));			        // 호출된 foo의 리턴값 data를 디코딩
    }
    
    function callBar(address addr) public {
        (bool success, bytes memory data) = addr.call(			// 주소를 사용하여 call 함수로 호출 
            abi.encodeWithSignature("doesNotExist()")			// 존재하지 않는 함수 --> fallback 함수 실행: xyz = 1
        );
    }
}
