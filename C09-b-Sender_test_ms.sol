pragma solidity >=0.4.22 <0.7.0;
import "remix_tests.sol"; // this import is automatically injected by Remix
import "remix_accounts.sol";
import "../C09-b-Sender.sol";

contract SenderTest is Sender {			                                                // Sender를 상속
    // 3개의 계정을 선언
    address acc0;
    address acc1;
    address acc2;
    
    //  "remix_accounts.sol" 라이브러리 함수를 이용하여 3개의 계정을 설정
    function beforeAll() public {
        acc0 = TestsAccounts.getAccount(0); 		
        acc1 = TestsAccounts.getAccount(1);
        acc2 = TestsAccounts.getAccount(2);
    }
    
    // 초기 owner가 올바르게 acc0으로 설정되었는지 검사
    function testInitialOwner() public {
        Assert.equal(getOwner(), acc0, 'owner should be acc0');
    }
    
    // owner를 변경하기
    function updateOwnerOnce() public {
        Assert.ok(msg.sender == acc0, 'caller should be acc0');	// msg.sender가 owner인지 검사
        updateOwner(acc1);							
        Assert.equal(getOwner(), acc1, 'owner should be updated to acc1');		        // owner가 acc1으로 변경되었는지 검사
    }
    
    // owner를 다시 변경하기 
    function updateOwnerOnceAgain() public {
        Assert.ok(msg.sender == acc1, 'caller should be acc1');	    // msg.sender가 owner인지 검사, 즉 acc1인지 검사
        updateOwner(acc2);
        Assert.equal(getOwner(), acc2, 'owner should be updated to acc2');		        // owner가 acc2으로 변경되었는지 검사
    }
}