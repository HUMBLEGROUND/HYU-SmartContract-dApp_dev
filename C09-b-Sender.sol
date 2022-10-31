pragma solidity >=0.4.22 <0.7.0;

contract Sender {
    address private owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function updateOwner(address newOwner) public {	                            // 요구사항: owner만이 owner를 교체할 수 있음
        //require(msg.sender == owner, "only current owner can update owner");
        if (msg.sender == owner)
            owner = newOwner;
    }
    
    function getOwner() public view returns (address) {
        return owner;
    }
}