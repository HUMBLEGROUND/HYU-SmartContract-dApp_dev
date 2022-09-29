pragma solidity ^0.6.4;

// [6주차]솔리더티 문법 4(EVM과 저장 위치)

/* 참조형 변수와 할당(assignment) 연산 */

/* 
(규칙 1) 스토리지 지역변수에 스토리지 변수를 할당할 경우 참조(reference)를 전달
(규칙 2) 메모리 지역변수간 할당은 참조(reference)를 전달
그 외: 값(value)을 복사
*/

contract ReferenceAssignment {
    /* 스토리지 상태변수 선언 */
    uint[2] public StorageStateA = [1, 2];
    uint[2] public StorageStateB = [3, 4];
    uint[2] public StorageStateC = [5, 6];
    uint[2] public StorageStateD = [7, 8];
    uint[2] public StorageStateE = [9, 10];
    uint[2] public StorageStateF = [11, 12];
    uint[2] public StorageStateG = [13, 14];
    uint[2] public StorageStateH = [15, 16];
    uint[2] public StorageStateI = [17, 18];
    uint[2] public StorageStateJ = [19, 20];
    uint[2] public StorageStateK = [21, 22];


    /* 스토리지 지역변수 <= 스토리지 상태변수, 스토리지 지역변수, 메모리 지역변수 */    
    function testAssign1() public returns (uint A, uint B) {
        uint[2] storage StorageLocalA = StorageStateA;
        uint[2] storage StorageLocalB = StorageStateB;
        uint[2] storage StorageLocalC = StorageStateC;
        uint[2] storage StorageLocalD = StorageStateD;
	    
        uint[2] memory MemoryLocalP = [uint(100), uint(200)];

        StorageLocalA = StorageStateE;          // (규칙 1) 스토리지 지역변수에 스토리지 상태변수를 할당하면 참조(reference) 전달
        StorageStateE[0] = 10000;               // 참조가 전달되었으므로 StorageStateA[0]도 10000으로 변경
	    
        StorageLocalB = StorageLocalC;          // (규칙 1) 스토리지 지역변수에 스토리지 지역변수를 할당하면 참조(reference) 전달
        StorageLocalC[0] = 20000;               // 참조가 전달되었으므로 StorageLocalB[0]도 20000으로 변경
	    
        // StorageLocalD = MemoryLocalP;        // 스토리지 지역변수 <= 메모리 지역변수, 컴파일러 에러 발생!
        // MemoryLocalP[0] = 30000;                        
	    
        return (StorageLocalA[0], StorageLocalB[0]);
    }
	  
	  
    /* 메모리 지역변수 <= 스토리지 상태변수, 스토리지 지역변수, 메모리 지역변수 */
    function testAssign2() public returns (uint Q, uint R, uint S) {
        uint[2] storage StorageLocalE = StorageStateF;
        
        uint[2] memory MemoryLocalQ = [uint(300), uint(400)];
        uint[2] memory MemoryLocalR = [uint(500), uint(600)];
        uint[2] memory MemoryLocalS = [uint(700), uint(800)];
        uint[2] memory MemoryLocalT = [uint(900), uint(1000)];
	    
        MemoryLocalQ = StorageStateG;           // 메모리 지역변수 <= 스토리지 전역변수
        StorageStateG[0] = 40000;               // 값(value) 복사
	    
        MemoryLocalR = StorageLocalE;           // 메모리 지역변수 <= 스토리지 지역변수
        StorageLocalE[0] = 50000;               // 값(value) 복사
	    
        MemoryLocalS = MemoryLocalT;            // (규칙 2) 메모리 지역변수간 할당할 경우 참조(reference)를 전달
        MemoryLocalT[0] = 60000;                // 참조가 전달되었으므로 MemoryLocalS[0]도 60000으로 변경
	    
        return (MemoryLocalQ[0], MemoryLocalR[0], MemoryLocalS[0]);
    }
    
    
    /* 스토리지 상태변수 <= 스토리지 상태변수, 스토리지 지역변수, 메모리 지역변수 */
    function testAssign3() public {
        uint[2] storage StorageLocalF = StorageStateF;
        uint[2] memory MemoryLocalU = [uint(1100), uint(1200)];
        
        StorageStateH = StorageStateI;          // 스토리지 상태변수 <= 스토리지 상태변수
        StorageStateI[0] = 70000;               // 값(value) 복사
	    
        StorageStateJ = StorageLocalF;          // 스토리지 상태변수 <= 스토리지 지역변수
        StorageLocalF[0] = 80000;               // 값(value) 복사
	    
        StorageStateK = MemoryLocalU;           // 스토리지 상태변수 <= 메모리 지역변수
        MemoryLocalU[0] = 90000;                // 값(value) 복사
    }
}

// Remix를 이용하여 “C06-b-ReferenceAssignment.sol” 컨트랙트 파일을 컴파일, 배포, 실행하시오. 

// HashFunction 컨트랙트의 testAssign1, testAssign2 함수를 순서대로 실행할 때 리턴값은 각각 얼마인가?

// testAssign1 함수 👉

// "0": "uint256: A 10000",
// "1": "uint256: B 20000"

// testAssign2 함수 👉

// "0": "uint256: Q 40000",
// "1": "uint256: R 80000",
// "2": "uint256: S 60000"