pragma solidity ^0.6.4;

/* 상속(inheritance): 함수 오버라이딩, 생성자 실행 순서 */

contract GrandParent {
	uint[5] public num;	
	string[5] public name;	
	constructor() public { num[0] = num[0] + num[1] + num[2] + num[3] + num[4] + 1; }
	function foo() public virtual returns (string memory) { 		    // 함수 오버라이딩을 위해 virtual 필요
	    name[0] = "Grand Parent"; return "Grand Parent"; 
	}
}

contract Parent1 is GrandParent {
	constructor() public { num[1] = num[0] + num[2] + 2; }
	function foo() public virtual override returns (string memory) { 	// GradnParent의 함수를 오버라이딩
	    name[1] = "Parent1"; return "Parent1"; 
	}
}

contract Parent2 is GrandParent {
	constructor() public { num[2] = num[0] + num[1] + 4; }
	function foo() public virtual override returns (string memory) { 	// GradnParent의 함수를 오버라이딩
	    name[2] = "Parent2"; return "Parent2"; 
	}
}

contract Child1 is Parent2, Parent1 {			    // Child1만 deploy할 경우, GrandParent --> Parent2 --> Parent1 --> Child1의 생성자 순으로 실행
	constructor() public { num[3] = num[2] + 8; }	// num[0] = 1, num[1] = 8, num[2] = 5, num[3] = 13 (num[4] = 0)
	function foo() 
	    public 
	    virtual 
	    override(Parent2, Parent1) 					// 오버라이딩하려는 부모 컨트랙트를 모두 명시
	    returns (string memory) 
	{ 
	    name[3] = "Child1"; return "Child1"; 	    // name[3] = "Child1" (나머지는 모두 "")
	}
}

contract Child2 is Parent2 {				        // Child2만 deploy할 경우, GrandParent --> Parent2 --> Child2의 생성자 순으로 실행
	constructor() public { num[4] = num[2] + 16; }	// num[0] = 1,  num[2] = 5, num[4] = 21 (num[1] = 0, num[3] = 0)
	function foo() 
	    public 
	    virtual 
	    override(Parent2) 
	    returns (string memory) 
	{ 
	    name[4] = "Child2"; return "Child2"; 	    // name[4] = "Child2" (나머지는 모두 "")
	}
}

