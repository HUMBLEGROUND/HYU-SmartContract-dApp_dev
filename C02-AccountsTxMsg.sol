pragma solidity ^0.6.4;

//[2주차]이더리움 블록체인과 스마트 컨트랙트

contract Callee {
    address payable public transactionOrigin; // 조회하는 사람(트랜잭션을 일으킨 주소)
    address payable public msgSender; // bar 함수를 실행시킨 사람(주소)
    address payable public owner; // 배포한 사람(주소)
    
    constructor() public {
		owner = msg.sender;
    } // owner = 배포하는 사람(주소)
	
    function bar() public payable { 
        transactionOrigin = tx.origin;
        msgSender = msg.sender;
    } // msgSender = 배포하는 사람(주소)
}

// bar / foo 함수
// 트랜잭션 발신자의 주소 / 메시지 발신자의 주소 / 블록과 관련된 정보들을 간단하게 기록하는 함수 

contract Caller {
    address payable public transactionOrigin; // 조회하는 사람(트랜잭션을 일으킨 주소)
    address payable public msgSender; // bar 함수를 실행시킨 사람(주소)
    address payable public owner; // 배포한 사람(주소)

    constructor() public {
		owner = msg.sender;
    } // owner = 배포하는 사람(주소)
	
    function foo(address payable _addr) public {
        transactionOrigin = tx.origin;
        msgSender = msg.sender;
        // msgSender = 배포하는 사람(주소)

        Callee callee = Callee(_addr); 
        // Callee 컨트랙트 주소로 foo 함수를 실행시킨 사람(주소)
        callee.bar();
    }
}

//Remix를 이용하여 “C02-AccountsTxMsg.sol” 컨트랙트 파일을 컴파일, 배포, 실행하시오.
// Callee 컨트랙트의 주소를 파라미터로 사용하여 👉 Caller의 foo() 함수를 실행하면
// Caller의 msg.sender와 tx.origin, Callee의 msg.sender와 tx.origin은 각각 어떤 계정의 주소로 바뀌는가?

// 1. Caller의 msg.sender와 tx.origin  👉  함수를 실행시킨 사람 (주소)
// 2. Callee의 msg.sender와 tx.origin  👉  Caller 의 트랜잭션 주소
