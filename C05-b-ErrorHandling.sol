pragma solidity ^0.6.10;

/* Error Handling: assert, require, revert */
contract ErrorHandling {
    struct Triangle {				                                    // 삼각형을 정의하는 구조체
        uint longEdge;	                    				            // 최장 길이의 변
        uint midEdge;						                            // 중간 길이의 변
        uint shortEdge;		                        		            // 최소 길이의 변
    }
    
    Triangle public myTriangle = Triangle(3, 2, 1);
    
    function testAssert(uint a, uint b, uint c) public {
        myTriangle.longEdge = a; 
        myTriangle.midEdge = b;
        myTriangle.shortEdge = c;
        
        assert(myTriangle.longEdge < 
            (myTriangle.midEdge + myTriangle.shortEdge)); 	            // 한 변의 길이는 두 변의 합보다 작아야 함
									                                    // 조건 위배시 revert (상태변수 변경 취소)
    }
    
    function testRequire(uint a, uint b, uint c) public {
        require(((a >= b) && (b >= c) && (c > 0)), 				        // 입력 파라미터는 길이 순서로 정렬되어야 함, 0보다 커야 함
            "Parameters must be ordered and greater than 0");			// 조건 위배시 revert (상태변수 변경 취소), 문자열 리턴
        
        myTriangle.longEdge = a; 
        myTriangle.midEdge = b;
        myTriangle.shortEdge = c;
    }

    function testRevert(uint a, uint b, uint c) public {
        myTriangle.longEdge = a; 
        myTriangle.midEdge = b;
        myTriangle.shortEdge = c;
        
        if (((a < b) || (b < c) || (c <= 0))) {					        // 입력 파라미터는 길이 순서로 정렬되어야 함
            revert("Parameters must be ordered and greater than 0");	// revert (상태변수 변경 취소)
        }
    }
}