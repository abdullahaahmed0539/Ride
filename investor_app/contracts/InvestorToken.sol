pragma solidity  >=0.4.22 <0.9.0;

contract InvestorToken {
    string public name = "RideX";
    string public symbol = "RDX";
    uint256 public totalSupply = 1000000000000000000000000; // 1 million tokens
    uint8 public decimals = 18;

    event Transfer(
        address indexed _from,
        address indexed _to, 
        uint _value
    );

    mapping(address => uint256) public balanceOf;
    
    constructor() public {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        // require that the value is greater or equal for transfer
        require(balanceOf[msg.sender] >= _value);

         // transfer the amount and subtract the balance
        balanceOf[msg.sender] -= _value;

        // add the balance
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }


}
