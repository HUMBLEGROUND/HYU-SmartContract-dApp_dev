pragma solidity ^0.6.4;

// [1주차]스마트 컨트랙트와 Remix 소개

contract ElectronicVote {
	uint public numCandidates; // 투표에 대상이 되는 후보들의 총 인원수
	string[] candidateNames; // 후보자들의 이름을 배열형태로 저장
	mapping (string => uint) public votesReceived; 
    // 후보자별로 몇명으로부터 투표를 받았는지 득표수를 저장

	constructor() public { // 컨트랙트가 최초에 배포될때 한번 실행되는 함수 (후보자등록)
		candidateNames.push("Alice");
		candidateNames.push("Bob"); // 배열에 push
		candidateNames.push("Chloe");
		numCandidates = 3; // 투표에 대상이 되는 후보들의 총 인원수 지정
	}

	function getCandidateName(uint index) public view returns(string memory) {
        // 후보자들의 이름을 열람하는 함수 👉 몇번째 후보자의 이름을 리턴 할지(index)
		if (index < candidateNames.length) 
		    return candidateNames[index];
		return "Invalid candidate";
		
	}

	function vote(string memory candidateName) public {	
        // 특정 후보자에게 표를 주는 함수	
		votesReceived[candidateName] += 1;
        // 투표하면 득표수 1씩 증가
	}

// “C01-ElecVote.sol” 컨트랙트 파일에 후보자를 추가로 등록시킬 수 있는 addCandidate(string memory candidateName) 함수를 추가하고,
// 본인이 구현한 함수의 소스 코드를 제출하시오. 
// (힌트: 주어진 코드의 constructor 함수를 참고하시오)

     function addCandidate(string memory candidateName) public {
         candidateNames.push(candidateName); // 후보자를 추가로 등록
         numCandidates += 1; // 등록될때마다 총 인원수 1씩 증가
     }
}
