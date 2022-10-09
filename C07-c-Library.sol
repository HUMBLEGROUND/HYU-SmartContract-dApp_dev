pragma solidity ^0.6.4;

/* 라이브러리 사용 예시 */

library SafeMath {							                        // 모든 함수가 internal이므로 컨트랙트 내부에 삽입됨 (배포 불필요)
    //uint public result;						                    // 라이브러리에서는 상태변수 정의 불가능
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");			    // 오버플로우 검사, 오버플로우 발생시 revert

        return c;
    }
    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");	// 오버플로우 검사, 오버플로우 발생시 revert

        return c;
    }
}

contract Caller {
    uint256 public addResult;
    uint256 public mulResult;
    
    function add(uint256 a, uint256 b) public {
        addResult = SafeMath.add(a, b);					            // "라이브러리명.함수명" 형식으로 호출
    }
    
    function mul(uint256 a, uint256 b) public {
        mulResult = SafeMath.mul(a, b);
    }
}
