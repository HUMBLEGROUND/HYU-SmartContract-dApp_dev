pragma solidity ^0.6.10;

/* if - else if - else 형식, break와 continue */
contract IfElse {
    function foo(uint x) public pure returns (uint) {	// x = 35라면 2를 리턴
        if (x < 10) {
            return 0; // x = 0 ~ 9 
        } else if (x < 20) {
            return 1; // x = 10 ~ 19
        } else {
            return 2; // x = 19 이상
        }
    }
}

contract Loop { // 반복문
    uint public sumFor;
    uint public sumWhile;
    
    function loop() public {
        for (uint i = 0; i < 10; i++) {	// sumFor = 12 (1 + 2 + 4 + 5)
        // 0 ~ 9 까지 순차적으로 출력
            if (i == 3) { // 3이 나오면 건너뛴다
                continue;
            }
            
            sumFor += i;
            
            if (i == 5) { // 5가 나오면 정지
                break;
            }
        }

        uint i;
        while (i < 10) { // sumWhile = 45 (1 + 2 + ... 4 + 9)
            sumWhile += i;
            i++;
        }
    }
}