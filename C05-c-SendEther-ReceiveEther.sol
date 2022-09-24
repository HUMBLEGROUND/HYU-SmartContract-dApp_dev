pragma solidity ^0.6.10;

// 5주차]솔리더티 문법 3 (함수 변경자, 이벤트, 예외 처리, 이더송수신)

/* 이더(ether) 송금: transfer, send, call */
contract SendEther {
    uint oneWei = 1;				                        // 솔리더티에서의 기본 단위는 wei
    uint twoWei = 2 wei;
    uint oneEther = 10**18;			                        // 1 ether = 10의 18승 
    uint twoEther = 2e18;			                        // 10의 18승의 동일한 표현
    uint threeEther = 3 ether;		                        // ether는 10의 18승을 의미
    
    uint public balance;    
    
    constructor() public payable {			                // 컨트랙트를 배포하면서 이더(ether) 송금	
        balance = msg.value;
    }      
   
    function sendViaTransfer(address payable _to) public {  // 실패시 예외(exception) 발생, 컨트랙트 실행을 "중단하고 revert"
        balance -= 2 ether;
        _to.transfer(2 ether);
    }
      
    function sendViaSend(address payable _to) public {	    // 실패시 bool 값을 반환, 컨트랙트 실행은 "계속" (revert 발생 없음)
        // balance -= 2 ether;				                // 송금 전에 balance를 먼저 갱신하면 balance에 틀린 값이 유지될 수 있음
        bool sent = _to.send(2 ether);
        if (sent == true)				                    // 정확한 balance를 유지하려면 조건 검사후 balance를 갱신 필요
            balance -= 2 ether;
    }
    
    function sendViaCall(address payable _to) public {	    // 실패시 bool 값을 반환, 컨트랙트 실행은 "계속" (revert 발생 없음)
        // balance -= 2 ether;				                // 송금 전에 balance를 먼저 갱신하면 balance에 틀린 값이 유지될 수 있음 
        (bool sent, bytes memory data) = _to.call{value: 2 ether}("xxx");
        if (sent == true)                                   // 정확한 balance를 유지하려면 조건 검사후 balance를 갱신 필요
            balance -= 2 ether;			                    
    }
    
    function getRealBalance() public returns (uint bal) {
        return address(this).balance;
    }
}

/* 이더(ether) 수신: payable function, receive, fallback */
contract ReceiveEther {
    uint public balance = 0;
    
    function payableFunction() public payable {			    // 이더를 수신할 수 있는 payable 함수
        balance += msg.value;
    }
    
    receive() external payable {				            // 이더를 수신할 수 있는 receive 함수
        //balance += msg.value;					            // 상태변수를 변경할 경우 이더 수신 실패 (버그?)
    }								                        // fallback 함수가 없을 경우 address.call로 송금된 이더 수신 가능
    
    fallback() external payable {				            // 이더를 수신할 수 있는 fallback 함수
        balance += msg.value;						
    }
    
    function getRealBalance() public returns (uint bal) {
        return address(this).balance;
    }
}

/* 컨트랙트 실행을 통한 확인
(1) 컨트랙트 배포
    (1-1) ReceiveEther 배포
    (1-2) SendEther 배포 (5 ether 송금)
(2) SendEther 컨트랙트 실행
    (2-1) ReceiveEther 주소 복사
    (2-2) sendViaCall( ) 실행 및 SendEther의 balance 확인 (3000000000000000000)
    (2-3) sendViaSend( ) 실행 및 SendEther의 balance 확인 (1000000000000000000)
    (2-4) sendViaTransfer( ) 실행, 트랜잭션 실패 확인, SendEther의 balance 확인 (1000000000000000000)
*/

/* 주의: receive 함수와 fallback 함수가 모두 존재할 경우 */
/* msg.data가 ""이면 receive 함수가 실행 */
/* msg.data가 "something that does not exit"이면 fallback 함수가 실행 */

// -------------------------------------------

// Remix를 이용하여 “C05-c-SendEther-ReceiveEther.sol” 컨트랙트 파일을 컴파일, 배포, 실행하시오.

// 단, SendEther 컨트랙트를 배포할 때는 7 ether를 송금한다. 

// ReceiveEther 컨트랙트의 주소를 파라미터로 SendEther의 sendViaCall, sendViaSend, sendViaTransfer 함수를 실행한 후 SendEther 컨트랙트의 이더 잔고는 각각 얼마인가?

//SendEther 컨트랙트의 이더 기존 잔고는 👉 7 이더

// 1. sendViaCall 함수 실행 👉 2 이더 전송

// 2. sendViaSend 함수 실행 👉 2 이더 전송

// 3. sendViaTransfer 함수 실행 👉 2 이더 전송

// 4. SendEther 컨트랙트의 이더 잔고는 👉 1 이더