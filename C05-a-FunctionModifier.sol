pragma solidity ^0.6.10;

/* 함수 변경자: 인자 및 함수의 실행 위치 */
contract FunctionModifier {
    address public owner;
    uint public x = 10;
    bool public locked;

    constructor() public {
        owner = msg.sender; // 내 주소
    }

    modifier onlyOwner() {						            
        require(msg.sender == owner, "Not owner");	// msg.sender와 owner 일치 여부를 검사
        _;								            // 함수의 실행 위치
    }

    modifier validAddress(address _addr) {				   
        require(_addr != address(0), "Not valid address");	// 입력 파라미터 address의 유효성 검사
        _;								                    // 함수의 실행 위치
    }

    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {// 2개의 변경자를 적용하는 함수
        
        owner = _newOwner;	// 함수 인자에 변경자의 입력 파라미터 포함										
    }

    modifier noReentrancy() {						       
        require(!locked, "No reentrancy"); // locked가 true 가 아닐경우 에러발생

        locked = true;
        _;				// true 일 경우 decrement 함수 실행
        locked = false;
    }

    function decrement(uint i) public noReentrancy {	    // 변경자를 적용하는 함수
        x -= i;

        if (i > 1) {
            decrement(i - 1);						        // 재귀적으로 x의 값을 감소 --> locked가 true이므로 require 조건 위배, revert 발생
        }
    }
}