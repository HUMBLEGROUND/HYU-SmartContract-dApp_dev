pragma solidity >=0.4.22 <0.7.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "../C09-a-SimpleStorage.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {

    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        // Here should instantiate tested contract
        Assert.equal(uint(1), uint(1), "1 should be equal to 1");
    }

    function checkSuccess() public {
        // Use 'Assert' to test the contract, 
        // See documentation: https://remix-ide.readthedocs.io/en/latest/assert_library.html
        Assert.equal(uint(2), uint(2), "2 should be equal to 2");
        Assert.notEqual(uint(2), uint(3), "2 should not be equal to 3");
    }

    function checkSuccess2() public pure returns (bool) {
        // Use the return value (true or false) to test the contract
        return true;
    }
    
    function checkFailure() public {
        Assert.equal(uint(1), uint(2), "1 is not equal to 2");
    }
}

contract MyTest {
    SimpleStorage foo;

    // SimpleStorage 객체 생성
    function beforeEach() public {
        foo = new SimpleStorage();
    }

    // 초기값 검사
    function initialValueShouldBe100() public returns (bool) {
        return Assert.equal(uint(foo.get()), 100, "initial value is not correct");
    }

    // storedData를 200으로 변경하는 테스트
    function valueIsSet200() public returns (bool) {
        foo.set(200);
        return Assert.equal(uint(foo.get()), 200, "value is not 200");
    }
    
    // storedData를 300으로 변경하는 테스트 (255로 변경되어야 함)
    function valueIsSet300() public returns (bool) {
        foo.set(300);
        return Assert.equal(uint(foo.get()), 255, "value is not 255");
    }
}