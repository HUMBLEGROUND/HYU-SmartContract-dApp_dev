pragma solidity ^0.6.4;

/* 데이터 저장 위치: 상태변수, 참조형 지역변수 */
contract DataLocationForDeclaration {
    uint public uintStorageStateA = 1;				                    // 상태변수의 저장위치는 항상 스토리지(storage). 변경 불가능
    
    uint[2] public arrayStorageStateB = [2, 3];			                // 상태변수의 저장위치는 항상 스토리지(storage). 변경 불가능
    
    mapping (uint => bool) public mappingStorageStateC;	                // 상태변수의 저장위치는 항상 스토리지(storage). 변경 불가능
    
    struct myStruct {			                       
        uint val;	                    
        bool ok;		                        
    }
    
    myStruct public structStorageStateD = myStruct(4, true);            // 상태변수의 저장위치는 항상 스토리지(storage). 변경 불가능   							
    
    
    function testDeclare() public returns (uint G, uint H, uint P, uint Q) {
        uint uintLocalA = 10;                                      
        // uint memory uintMemoryLocalB;                                // 밸류형 변수는 저장 위치를 지정할 수 없음. 컴파일러 에러!
        // uint storage uintStorageLocalC;                              // 밸류형 변수는 저장 위치를 지정할 수 없음. 컴파일러 에러!
	    
        // uint[2] arrayLocalD;                                         // 배열, 구조체, 매핑은 항상 저장 위치를 지정해야 함. 컴파일러 에러!
        uint[2] memory arrayMemoryLocalE = [uint(20), uint(30)];	    // 메모리로 지정된 참조형 변수는 객체를 생성.
        // uint[2] storage arrayStorageLocalF = [uint(40), uint(50)];   // 스토리지로 지정할 경우 상태변수로 초기화해야 함. 컴파일러 에러!
        uint[2] memory arrayMemoryLocalG = arrayStorageStateB;          // 복사(copy) 발생, [2, 3] 할당
        uint[2] storage arrayStorageLocalH = arrayStorageStateB;        // (규칙 1) 스토리지 지역변수에 스토리지 변수를 할당하면 참조(reference) 전달
        arrayStorageStateB[0] = 60;                                     // 참조가 전달되었으므로 arrayStorageLocalH[0]도 60으로 변경
	    
        // mapping (uint => bool) mappingLocalI;                        // 참조형 변수는 항상 저장 위치를 지정해야 함. 컴파일러 에러!
        // mapping (uint => bool) memory mappingMemoryLocalJ;           // 매핑은 스토리지로 지정해야 함. 컴파일러 에러!
        // mapping (uint => bool) storage mappingStorageLocalK;         // 매핑은 스토리지로 지정해야 하며 상태변수로 초기화해야 함. 컴파일러 에러!
        mapping (uint => bool) storage mappingStorageLocalL = mappingStorageStateC;     
        // ⭐ mapping은 key-value 형식으로 데이터가 저장되어서 스토리지로 저장된다
        // memory는 byte 만 저장
	    
        // myStruct structLocalM = myStruct(70, true);                  // 참조형 변수는 항상 저장 위치를 지정해야 함. 컴파일러 에러!
        myStruct memory structMemoryLocalN = myStruct(80, true);		// 메모리로 지정된 참조형 변수는 객체를 생성.
        // myStruct storage structStorageLocalO = myStruct(90, true);   // 스토리지로 지정할 경우 상태변수로 초기화해야 함. 컴파일러 에러!
        myStruct memory structMemoryLocalP = structStorageStateD;       // 복사(copy) 발생, (4, true) 할당
        myStruct storage structStorageLocalQ = structStorageStateD;     // (규칙 1) 스토리지 지역변수에 스토리지 변수를 할당하면 참조(reference) 전달
        structStorageStateD.val = 100;                                  // 참조가 전달되었으므로 structStorageLocalQ.val도 100으로 변경
	    
        return (arrayMemoryLocalG[0], arrayStorageLocalH[0], structMemoryLocalP.val, structStorageLocalQ.val);
    }
}