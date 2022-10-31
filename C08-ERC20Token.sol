pragma solidity 0.6.4;

/* ERC20 표준 인터페이스 */
abstract contract EIP20Interface {					                    // EIP(Ethereum Improvement Proposal) 표준을 정의하는 추상 컨트랙트
    uint256 public totalSupply;					                        // 토큰의 총 발행량	(예, 30000)		

    function balanceOf(address _owner) 				                    // 토큰의 잔고 확인
	public virtual view returns (uint256 balance);		
    function transfer(address _to, uint256 _value) 			            // _to에게 _value 수량의 토큰을 송금
	public virtual returns (bool success);		
    function transferFrom(address _from, address _to, uint256 _value) 	// _from으로부터 _to에게 _value 수량의 토큰을 이동
	public virtual returns (bool success);		
    function approve(address _spender, uint256 _value) 			        // msg.sender가 _spender에게 자신의 토큰 중에서 _value 수량의 사용을 허락 --> allowed
	public virtual returns (bool success);	
    function allowance(address _owner, address _spender) 		        // _owner가 _spender에게 사용을 허락한 토큰의 잔량을 확인
	public virtual view returns (uint256 remaining);		
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);		    // 송금 발생시(transfer) 이벤트 생성
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);	// 사용 허락시(approve) 이벤트 생성
}

/* ERC20 표준 토큰 */
contract ERC20Token is EIP20Interface {				                    // EIP20Interface 추상 컨트랙트를 상속

    uint256 constant private MAX_UINT256 = 2**256 - 1;			        // uint256의 최대값을 상수로 정의
    mapping (address => uint256) balances;                              // 계정별(address) 토큰 잔고
    mapping (address => mapping (address => uint256)) allowed;          // approve()에 의해 사용이 허락된 토큰 잔고
   
    string public name;                   					            // 토큰의 명칭 (예, KOREA WON)
    uint8 public decimals;                					            // 소수점 이하 자리수 (예., 3)
    string public symbol;                 					            // 토큰의 심볼 (예, KOR)

    constructor(uint256 _initialAmount, string memory _tokenName, uint8 _decimalUnits, string memory _tokenSymbol) public {
        balances[msg.sender] = _initialAmount;               			// _initialAmount를 컨트랙트 배포자에게 제공
        totalSupply = _initialAmount;                        			// _initialAmount는 토큰 총 발행량
        name = _tokenName;                                   			// 토큰의 명칭 설정
        decimals = _decimalUnits;                            			// 소수점 이하 자리수 설정
        symbol = _tokenSymbol;                               			// 토큰의 심볼 설정
    }

    function balanceOf(address _owner) public view override returns (uint256 balance) {
        return balances[_owner];					                    // _owner의 토큰 잔고
    }
    
    function transfer(address _to, uint256 _value) public override returns (bool success) { 
        require(balances[msg.sender] >= _value, "Error 1");			    // msg.sender의 잔고 검사
        balances[msg.sender] -= _value;					                // msg.sender의 잔고로부터 _value 차감
        balances[_to] += _value;					                    // _to의 잔고에 _value 추가
        emit Transfer(msg.sender, _to, _value); 				        // Transfer 이벤트 발생
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value, "Error 2");	// _from의 잔고 검사, _from이 허락한 수량(allowed) 확인
        balances[_to] += _value;					                    // _to의 잔고에 _value 추가
        balances[_from] -= _value;					                    // _from의 잔고로부터 _value 차감
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;				        // _from이 허락하는 수량(allowed)으로부터 _value 차감
        }
        emit Transfer(_from, _to, _value); 				                // Transfer 이벤트 발생
        return true;
    }

    function approve(address _spender, uint256 _value) public override returns (bool success) {
        allowed[msg.sender][_spender] += _value;			            // msg.sender가 _spender에게 자신의 토큰 중에서 _value 수량의 사용을 허락
        emit Approval(msg.sender, _spender, _value); 			        // Approve 이벤트 발생
        return true;
    }

    function allowance(address _owner, address _spender) public view override returns (uint256 remaining) {
        return allowed[_owner][_spender];				                // _owner가 _spender에게 사용을 허락한 토큰의 수량
    }
}

/* 컨트랙트 실행을 통한 확인
(1) 컨트랙트 배포: (30000, KOREA, 3, KOR) = (총 발행량, 토큰 명칭, 소수점 이하 자리수, 토큰 심볼)
    (1-1) balanceOf, decimals, name, symbol, totalSupply 확인
(2) transfer(address, uint256) 함수 실행
    (2-1) Remix의 2번 계정 주소 복사
    (2-2) 1번 계정으로 전환
    (2-3) 2번 계정으로 10000 송금
    (2-4) 2번 계정의 balanceOf 함수 실행 --> 10000
    (2-5) 1번 계정의 balanceOf 함수 실행 --> 20000
(3) approve(address, uint256) 함수 실행
    (3-1) 2번 계정 주소 복사
    (3-2) 1번 계정으로 전환
    (3-3) 2번 계정에 5000 사용권한 부여하는 approve 함수 실행
    (3-4) allowed(1번 주소, 2번 주소) 확인 --> 5000
(4) transferFrom(address, address, uint) 함수 실행
    (4-1) 2번 계정으로 전환
    (4-2) 1번 계정의 5000을 3번 계정으로 송금하는 transferFrom(1번 주소, 3번 주소, 5000) 실행
    (4-3) 3번 계정의 balanceOf 함수 실행 --> 5000
    (4-4) 1번 계정의 balanceOf 함수 실행 --> 15000
*/
//----------------------------------
// “C08-ERC20Token.sol” 컨트랙트 파일의 approve 함수는 msg.sender의 토큰 잔고를 확인하지 않고
// _spender에게 _value 만큼의 토큰을 허락한다. 

// 적절한 require 구문을 삽입하여 msg.sender의 토큰 잔고가 
// _value보다 같거나 클 경우에만 allowed 값을 갱신하도록 수정하고, 
// 수정된 approve 함수의 소스 코드를 제출하시오.


    function approve(address _spender, uint256 _value) public override returns (bool success) {
        require(address(msg.sender).balance >= _value, "Error"); // 👉 require문 추가
        allowed[msg.sender][_spender] += _value;			           
        emit Approval(msg.sender, _spender, _value); 			 
        return true;
    }