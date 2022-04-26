// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./rideToken.sol";
import "./investorToken.sol";

contract Controller {

    rideToken coins;
    investorToken stocks;
    address watcher;
    address owner;
    address vault;
    uint collatForDriver;
    mapping (address => uint) collatAmount;
    mapping (address => uint) driverToCode;
    mapping (address => uint) userBalances;

    struct disputeInfo{
        address rider;
        address driver;
        uint disputeAmount;
        uint winner; //1 means rider won, 2 means driver won
    }

    disputeInfo[] disputeInfoHolder;

    constructor() {
        owner = msg.sender;
        // coins = RideToken(<Address of ERC20 tokens>);
        coins = rideToken(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2); //THIS IS WETH ADDRESS BEING USED FOR TESTING TILL OUR ERC20 IS READY 
        // stocks = investorToken(<Address of ERC721 tokens>);
        stocks = investorToken(0x6409d3A686c2ab9b418Fb3CB5b4778509c5cADd6); //THIS IS HAPPY SHARK NFT ADDRESS BEING USED FOR TESTING TILL OUT ERC721 IS READY
        watcher = msg.sender;
        vault = 0x854ad6ac9d7a8CD71A4515C4267e3d1d14EF65E9; //THIS IS A TEST WALLET ADDRESS. THIS WILL BE REPLACED BY A GNOSIS SAFE ADDRESS.
        
    }

    // Modifier to check that the caller is the owner of
    // the contract.
    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner.");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

    fallback() external payable { //Called when no other function matches (or if call data is empty and receive function does not exist)
        // custom function code
    }

    receive() external payable { //Called when call data is empty
        // custom function code
    }

    function collectCollatFromDriver(uint _amount) external { //At the moment, the collateral will be saved in the form of our Ride Coins
        require(_amount >= collatForDriver, "Insufficient amount.");
        coins.approve(vault, _amount);
        coins.transferFrom(msg.sender, vault, _amount);
        collatAmount[msg.sender] = _amount;

    }

    function giveAllCollatToDriver(address _driver) external {
        require(_driver == msg.sender, "Please specify your valid wallet address.");
        coins.transferFrom(vault, msg.sender, collatAmount[msg.sender]);
        collatAmount[msg.sender] = 0;

    }

    function giveCollatToDriver(address _driver, uint _amount) external {
        require(_driver == msg.sender, "Please specify your valid wallet address.");
        require(_amount <= collatAmount[msg.sender], "Insufficient amount held in balance.");
        _amount = collatAmount[msg.sender] - _amount;
        coins.transferFrom(vault, msg.sender, _amount);
        collatAmount[msg.sender] = 0;

    }

    function setAmountForCollat(uint _amount) private onlyOwner { //Allow admin to adjust the collateral amount
        require(msg.sender == watcher, "Only the admin can set this value.");
        // collatForDriver = amount * (1 ether);
        collatForDriver = _amount;
    }

    //When the driver calls this function, a random number is generated. This random number is sent to the Rider.
    //The Rider will use that number to begin the ride from his end. This way, the ride only starts when both the parties agree.
    //paramOne is the phone number of the Driver.
    function startRideDriver(string memory _paramOne) public returns (uint) { 
        uint random = uint(keccak256(abi.encode(_paramOne, msg.sender, block.timestamp)));
        driverToCode[msg.sender] = random;
        return random;
    }

    //Both the Rider and the Driver have to end the ride session for it to end.
    //Both the functions will simply return a 1, which indicates that the end order has been issued.
    //If both the functions result in a 1, the Frontend will know that the ride has been ended.
    function endRideDriver() public pure returns (uint) {
        return 1;
    }

    function startRideRider(uint _code, address _driver) public view returns (uint8){ //NEED TO ADD PRICE VARIABLE
        require(driverToCode[_driver] == _code, "Driver has sent an invalid code.");
        return 1; // 1 means the session is good to go.

    }

    function endRideRider() public pure returns (uint) {
        return 1;
    }
    //Collect Collateral from Driver (done)
    //Make events for future query using theGraph
    //Allow rides to happen (done)
    //Allow people to buy Ride Tokens
    //Allow people to buy Stock/NFT
    //Allow the voting to take place
    //Handle mapping for Address > Name (optional)
    //View functions for reading different things like Balance/Owner
    //Extra info will be kept in the Database. This includes location and cost of ride.
    //Decide what to save on-chain. This may include voting related data.

    function mintRideCoins(address _rider, uint _amount) public {
        // require(_amount >= collatForDriver, "Insufficient amount.");
        //call mint here
        coins.approve(vault, _amount);
        coins.transferFrom(_rider, vault, _amount);
        userBalances[_rider] = _amount;
    } 

    function riderBalances(address _rider) public view returns (uint){
        return riderBalances(_rider);
    }

    function collectDisputeAmount(address _rider, uint _riderAmount, address _driver, uint _driverAmount) public returns (uint) {
        require(_riderAmount >= userBalances[_rider], "User has insufficient funds.");
        require(_driverAmount >= collatAmount[_driver], "Driver has insufficient collateral amount.");
        userBalances[_rider] = userBalances[_rider] - _riderAmount;
        collatAmount[_driver] = collatAmount[_driver] - _driverAmount;
        disputeInfoHolder[disputeInfoHolder.length] = disputeInfo(_rider, _driver, (_riderAmount + _driverAmount), 0);
        uint index = disputeInfoHolder.length - 1;
        return index;
    }

    function disputeResult(uint _riderVote, uint _driverVote, uint index) public {
            disputeInfo memory resolvedDispute = disputeInfoHolder[index];
        if (_riderVote > _driverVote) {
            // disputeInfo resolvedDispute = disputeInfoHolder[index];
            userBalances[resolvedDispute.rider] = userBalances[resolvedDispute.rider] + resolvedDispute.disputeAmount;
            resolvedDispute.winner = 1;
        } else {
            // disputeInfo resolvedDispute = disputeInfoHolder[index];
            collatAmount[resolvedDispute.driver] = collatAmount[resolvedDispute.driver] + resolvedDispute.disputeAmount;
            resolvedDispute.winner = 2;
        }
    }

}