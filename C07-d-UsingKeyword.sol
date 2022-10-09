pragma solidity ^0.6.4;

/* Using 사용 예시 */

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }
    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }
}

contract Caller {
    using SafeMath for uint256;			            // SafeMath를 uint256 자료형으로 사용함을 선언
    
    uint256 public addResult;				
    uint256 public mulResult;				
    
    function add(uint256 a, uint256 b) public {		// uint256 자료형인 a와 b를 SafeMath 객체처럼 사용
        addResult = a.add(b);				        // a.add(b)는 SafeMath.add(a, b)와 같은 의미
    }
    
    function mul(uint256 a, uint256 b) public {
        mulResult = SafeMath.mul(a, b);			    // SafeMath.mul(a, b)는 a.mul(b)와 같은 의미
    }
}

