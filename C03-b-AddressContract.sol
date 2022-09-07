pragma solidity ^0.6.4;

/* 주소형(address)과 컨트랙트형(contract)의 문법적 성질 */
// [3주차]솔리더티 문법 1 (변수 유형과 자료형)

contract ContractA {					
    uint public X;
    uint public Y;
    uint public Z;
    
    function getVal() public returns (uint a, uint b, uint c) {
        return (X, Y, Z);
    }
    
    function setX(uint a) public {
        X = a;
    } 
    
    function setY(uint a) public {
        Y = a;
    }
    
    function setZ(uint a) public {
        Z = a;
    }
    
}

/* 주소형과 컨트랙트형은 상호간 변환 가능 */
/* 주소형 또는 컨트랙트형을 이용한 함수 호출은 call-by-reference 스타일 */
contract ContractB {
   
    function callX(address payable addr) public {		
        ContractA callee1 = ContractA(addr);                // "주소형(address) --> 컨트랙트형(contract)" 형변환 가능
        address payable addr2 = payable(address(callee1));	// "컨트랙트형(contract) --> 주소형(address)" 형변환 가능
        ContractA callee2 = ContractA(addr2);		        // 주소형(address)을 컨트랙트형(contract)으로 다시 변환
        callee2.setX(100);				                    // 파라미터로 받은 원래 컨트랙트의 X값이 100으로 변경
    }
    
    function callY(address payable addr) public {		
        ContractA callee1 = ContractA(addr);                // "주소형(address) --> 컨트랙트형(contract)" 형변환
        ContractA callee2 = new ContractA();
        callee2 = callee1;                                  // 컨트랙트 할당(assignment), 새로 할당된 객체를 참조(reference)
        
        callee2.setY(200);				                    // 원래 컨트랙트의 Y값이 200으로 변경
    }
    
    function callZ(address payable addr) public {		
        ContractA callee1 = ContractA(addr);                // "주소형(address) --> 컨트랙트형(contract)" 형변환
        callByContract(callee1);
    }
    
    function callByContract(ContractA ca) public {          // 컨트랙트를 함수 인자로 사용 (call by reference)
        ca.setZ(300);					                    // 원래 컨트랙트의 Z값이 300으로 변경
    }
}

/* 컨트랙트 실행을 통한 확인 
(1) ContractA 배포
(2) ContractB 배포
(3) ContractA의 주소를 인자로 사용하여 ContractB의 callX( ), callY( ), callZ( )를 실행 --> X=100, Y=200, Z=300 확인
*/

//Remix를 이용하여 “C03-b-AddressContract.sol” 컨트랙트 파일을 컴파일, 배포, 실행하시오. 

// ContractA 컨트랙트의 주소를 파라미터로 사용하여 ContractB의 callX, callY, callZ 함수를 실행하면 
// ContractA 컨트랙트의 X, Y, Z의 값은 각각 얼마가 되는가?
// X = 100 / Y = 200 / Z = 300