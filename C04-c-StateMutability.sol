pragma solidity ^0.6.10;

/* 상태변경성(state mutability): view, pure, payable */
contract StateMutability {
    uint public stateVar = 10;
    uint public balanceEther = 0;
    
    function viewFunction() public view returns (uint) {	
        return stateVar;
    }
    
    function pureFunction() public pure returns (uint) {	
        return 10 + 20;
    }
    
    function payableFunction() public payable {		
        // 이더(ether) 수신 또는 msg 객체 참조시 payable로 지정
        balanceEther = msg.value;
    }
}