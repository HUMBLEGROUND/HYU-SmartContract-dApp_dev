pragma solidity >=0.4.22 <0.7.0;

contract SimpleStorage {
    uint8 public storedData;                    // 요구사항: if storedData > 255, then storedData = 255

    constructor() public {
        storedData = 100;
    }

    function set(uint x) public {
        if (uint8(x) > 255)                     // if (x > 255) ?
            storedData = 255;
        else 
            storedData = uint8(x);
    }

    function get() public view returns (uint8 retVal) {
        return storedData;
    }
}