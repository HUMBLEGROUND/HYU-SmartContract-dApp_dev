pragma solidity ^0.6.4;

// [7주차]솔리더티 문법 5(연동 상속)

/* call, delegatecall, staticcall 비교 */ 

contract Receiver {
    uint public stateVal;
    address public msgSender;
    
    function setVars(uint val) public payable {				                // Caller 컨트랙트에서 호출될 함수, 상태변수 stateVal 및 msgSender 변경
        stateVal = val;
        msgSender = msg.sender;
    }
}

contract Caller {
    uint public stateVal;						                            // Receiver의 상태변수와 동일한 이름을 가지는 상태변수 선언
    address public msgSender;

    // address.call( ) 함수: Receiver의 컨텍스트에서 실행
    function setVarsCall(address addr, uint val) public payable {	        // Receiver의 상태변수가 변경됨
        (bool success, bytes memory data) = addr.call(			            // Receiver의 msg.sender가 Caller의 주소로 변경됨
            abi.encodeWithSignature("setVars(uint256)", val)
        );
    }
    
    // address.delegatecall( ) 함수: Caller의 컨텍스트에서 실행
    function setVarsDelegateCall(address addr, uint val) public payable {	// Caller의 상태변수가 변경됨
        (bool success, bytes memory data) = addr.delegatecall(		        // Caller의 msg.sender가 트랜잭션 발생자의 주소로 변경됨
            abi.encodeWithSignature("setVars(uint256)", val)
        );
    }
    
    // address.staticcall( ) 함수: 상태변수 변경 없음
    function setVarsStaticCall(address addr, uint val) public payable {	    // Caller와 Receiver의 상태변수가 변경되지 않음    
        (bool success, bytes memory data) = addr.staticcall(
            abi.encodeWithSignature("setVars(uint256)", val)
        );
    }
}

/* 컨트랙트 실행을 통한 확인
(1) 컨트랙트 배포
    (1-1) Receiver 배포
    (1-2) Caller 배포
(2) Caller 컨트랙트 실행
    (2-1) Receiver 주소 복사
    (2-2) setVarsCall( ) 실행, Caller와 Receiver의 상태변수를 각각 확인 (Receiver의 값만 변경됨)
    (2-3) setVarsDelegateCall( ) 실행, Caller와 Receiver의 상태변수를 각각 확인 (Caller의 값만 변경됨)
    (2-4) setVarsStaticCall( ) 실행, Caller와 Receiver의 상태변수를 각각 확인 (Caller와 Receiver의 값이 모두 변경되지 않음)
*/

//---------------------------------------

// Remix를 이용하여 “C07-b-DelegateCall.sol” 컨트랙트 파일을 컴파일, 배포, 실행하시오. 

// Receiver 컨트랙트의 주소와  1024라는 숫자를 파라미터 함수인자로 Caller의 setVarsCall, setVarsDelegateCall, setVarsStaticCall 함수를 실행하면

// Receiver 컨트랙트의 stateVal과 msgSender의 값은 각각 어떻게 되는가?

// Receiver 컨트랙트의 stateVal 값 👉 Caller의 컨트랙트 주소
// Receiver 컨트랙트의 msgSender 값 👉 1024