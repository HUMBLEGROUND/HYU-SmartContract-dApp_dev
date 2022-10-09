pragma solidity ^0.6.4;

/* 추상 컨트랙트 */
abstract contract Parent {
	string[2] public fooName;                                           // 추상 컨트랙트에서는 상태변수 정의 가능
	string[2] public barName;	
	
	function foo() public virtual returns (string memory) { 	        // (모든) 함수가 구현되어도 추상 컨트랙트로 지정할 수 있음
	    fooName[0] = "Parent"; return "Parent"; 
	}
	
	function bar() public virtual returns (string memory);
}

/* 추상 컨트랙트를 상속하는 컨트랙트 */
contract Child is Parent {					                            // 일반적인 상속과 동일한 방법으로 추상 컨트랙트를 상속
	/*									                                // Child만 배포시 foo()와 bar() 실행 가능
	function foo() public virtual override returns (string memory) { 	// 오버라이딩을 안할 경우 foo()를 실행하면 Parent의 foo() 실행
	    fooName[1] = "Child"; return "Child"; 					        // fooName[0] = "Parent", fooName[1] = ""
	} */
	
	function bar() public virtual override returns (string memory) { 
	    barName[1] = "Child"; return "Child"; 
	}
}

/* 인터페이스 */
interface Coordinate {							                        // 인터페이스는 컨트랙트 상속 불가능, 다른 인터페이스 상속은 가능
	//uint public x;				                                    // 인터페이스에서는 상태변수 정의 불가능 (라이브러리와 유사)
	//uint public y;
	
	function moveCoordinate(uint a, uint b) external;			        // 모든 함수가 구현되어 있지 않아야 함
	function getCoordinate() external returns (uint, uint);				// 모든 함수는 external 이어야 함
}

/* 인터페이스를 상속하는 컨트랙트 */
contract Point is Coordinate {				                            // 일반적인 상속과 동일한 방법으로 인터페이스를 사용
    uint public p;
	uint public q;
	
	function moveCoordinate(uint a, uint b) external override {
	    p += a;
	    q += b;
	}
	
	function getCoordinate() external override returns (uint, uint) {
	    return (p, q);
	}
}
