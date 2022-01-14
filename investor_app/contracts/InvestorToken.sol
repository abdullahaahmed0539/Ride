/*
DOCUMENTATION
This contract is a corporate bond. It will behave in the following way:
1) It will have a name and a ticker/symbol.
2) One unit cannot be divided into decimals.
3) It can be minted only once by the address which deploys the smart contract.
4) At the time of minting the bonds, the following will be provided by the minter:
    • principle which will be in USD
    • interest rate
    • duration 
    • the total supply of bonds
5) The first buyers of the bonds from Ride will pay ethers equivalent to the principle. Later buyers can sell it
   any price they want in ethers.
6) Ride will pay out interest amount in ethers yearly. This amount will be equivalent to A = PRT/100. This interest
   will be paid to addresses with holding bonds.
7) At maturity, the investors will get their principle, the bonds will be destroyed and contract will terminate
*/








pragma solidity  >=0.4.22 <0.9.0;

contract InvestorToken {
    string public name = "RideX";
    string public symbol = "RDX";
    uint8 public decimals = 0;
    uint256 public totalSupply; 
    uint256 public principle;
    uint64 public rate;
    uint8 public duration;
    uint256 public interestAmount;
    address private minter;
    bool private minted = false;
    mapping(address => uint256) public balanceOf;
    
    event Mint (
        uint amount
    );
        
    event Transfer(
        address indexed _from,
        address indexed _to, 
        uint _value
    );
    
    constructor() public {
        minter = msg.sender;
    }

    function mint (uint256 _amount, uint256 _principle, uint64 _rate, uint8 _duration) public {
        require(msg.sender == minter && !minted, "Permission denied to mint.");
        minted = true;
        principle = _principle;
        rate = _rate;
        duration = _duration;
        interestAmount = (principle * rate * duration) / 100;
        totalSupply += _amount;
        balanceOf[minter] += totalSupply;
        emit Mint(_amount);
    }

//need help
    function transfer(address _to, uint256 _value) public payable {
        require(balanceOf[msg.sender] >= _value, "You have insufficient tokens.");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }

    // function payInterest () public payable {
    //     require(msg.sender == minter, "You do not have the athority to pay interest.");
    // }


}
