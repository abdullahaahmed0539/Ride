// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./rideToken.sol";
// import "./investorToken.sol";

contract Controller {

    RideToken public coins;
    // investorToken stocks;
    address public watcher;
    address private owner;
    // address private vault;
    uint private collatForDriver;
    // mapping (address => uint) collatAmount;
    // mapping (address => uint) driverToCode;
    mapping (address => uint) userBalances;
    mapping (address => uint) userDeficit;
    uint private moneySum;

    // struct DisputeInfo{
    //     address rider;
    //     address driver;
    //     uint disputeAmount;
    //     uint winner; //1 means rider won, 2 means driver won
    // }

    event Booking(
        string bookingID, 
        string riderID, 
        string driverID, 
        string bookingTime, 
        string pickup, 
        string dropoff, 
        string status
        );

    event Trip(
        string bookingID,
        string distance,
        string startTime,
        string endTime,
        // string duration,
        // string driverArrivalTime,
        // string waitTime,
        string total,
        string fuelCost,
        string waitTimeCostPerMin,
        string disputeCost,
        string waitTimeCost,
        string milesCost
        // string riderRating,
        // string driverRating
    );

    // struct BookingLog{
    //     string bookingID; 
    //     string riderID;
    //     string driverID;
    //     string bookingTime; 
    //     string pickup; 
    //     string dropoff; 
    //     uint fuelCost;
    //     string distance; 
    //     uint totalCost;
    // }

    // DisputeInfo[] private disputeInfoHolder;
    // BookingLog[] public bookingInfoHolder;

    constructor() {
        owner = msg.sender;
        // coins = RideToken(<Address of ERC20 tokens>);
        //THIS IS WETH ADDRESS BEING USED FOR TESTING TILL OUR ERC20 IS READY 
        coins = RideToken(0xd4E945C1a8EBCbCB9B3411fD4EcE1DA9FE571365); 
        watcher = msg.sender;
        moneySum = 0;  
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

    //Called when no other function matches (or if call data is empty and receive function does not exist)
    fallback() external payable { 
        // custom function code
    }

    receive() external payable { //Called when call data is empty
        // custom function code
    }

    //At the moment, the collateral will be saved in the form of our Ride Coins
    function checkifSufficientCollat(address _driver) external view returns (bool){ 
        if (userBalances[_driver] >= collatForDriver) {
            return true;
        } else return false;
    }

    function checkifSufficientCoins(address _rider, uint _estimateFare) external view returns (bool){ 
        if (userBalances[_rider] >= _estimateFare) {
            return true;
        } else return false;
    }

    function giveCollatToDriver(address _driver, uint _amount) external onlyOwner(){
        // require(_driver == msg.sender, "Please specify your valid wallet address.");
        uint remaining = 0;
        if (userDeficit[_driver] > 0) {
            remaining = userDeficit[_driver];
        }
        _amount = _amount - remaining;
        require(_amount <= userBalances[_driver], "Insufficient amount held in balance.");
        _amount = userBalances[_driver] - _amount;
        coins.transferFrom( address(this), _driver, _amount);
        userBalances[_driver] -= _amount;
        moneySum -= _amount;
    }

    function setAmountForCollat(uint _amount) private onlyOwner { //Allow admin to adjust the collateral amount
        require(msg.sender == watcher, "Only the admin can set this value.");
        // collatForDriver = amount * (1 ether);
        collatForDriver = _amount;
    }

    //When the driver calls this function, a random number is generated. This random number is sent to the Rider.
    //The Rider will use that number to begin the ride from his end.
    //This way, the ride only starts when both the parties agree.
    //paramOne is the phone number of the Driver.
    // function startRideDriver(string memory _paramOne) public returns (uint) { 
    //     uint random = uint(keccak256(abi.encode(_paramOne, msg.sender, block.timestamp)));
    //     driverToCode[msg.sender] = random;
    //     return random;
    // }

    //Both the Rider and the Driver have to end the ride session for it to end.
    //Both the functions will simply return a 1, which indicates that the end order has been issued.
    //If both the functions result in a 1, the Frontend will know that the ride has been ended.
    // function endRideDriver() public pure returns (uint) {
    //     return 1;
    // }

    // function startRideRider(uint _code, address _driver) public view returns (uint8){ //NEED TO ADD PRICE VARIABLE
    //     require(driverToCode[_driver] == _code, "Driver has sent an invalid code.");
    //     return 1; // 1 means the session is good to go.

    // }

    // function endRideRider() public pure returns (uint) {
    //     return 1;
    // }
    //Collect Collateral from Driver (done)
    //Make events for future query using theGraph
    //Allow rides to happen (done)
    //Allow people to buy Ride Tokens (done)
    //Allow people to buy Stock/NFT (cancelled)
    //Allow the voting to take place (?)
    //Handle mapping for Address > Name (optional)
    //View functions for reading different things like Balance/Owner (done)
    //Extra info will be kept in the Database. This includes location and cost of ride. (done)
    //Decide what to save on-chain. This may include voting related data. (?)

    function mintRideCoins(address _buyer, uint _amount) public onlyOwner(){
        uint remaining = 0;
        if (userDeficit[_buyer] > 0) {
            remaining = userDeficit[_buyer];
        }
        _amount = _amount - remaining;
        coins.mint(_buyer, _amount);
        coins.approve( address(this), _amount);
        coins.transferFrom(_buyer,  address(this), _amount);
        userBalances[_buyer] = _amount;
        moneySum += _amount;
    } 

    function getBalances(address _user) public view returns (uint){
        return userBalances[_user];
    }

    function collectDisputeAmount(
        address _rider, 
        uint _amount, 
        address _driver
        ) public {
            if (userBalances[_driver] < _amount) {
                moneySum -= _amount; //In case of no money, server gives money and puts deficit counter.
                userDeficit[_driver] += _amount;
                // moneySum -= _amount;
            } else {
                userBalances[_driver] = userBalances[_driver] - _amount;
            }
            require(_amount >= userBalances[_rider], "User has insufficient funds.");
            // require(_amount >= userBalances[_driver], "Driver has insufficient collateral amount.");
            userBalances[_rider] = userBalances[_rider] - _amount;
            // userBalances[_driver] = userBalances[_driver] - _amount;
            moneySum += (_amount + _amount);
    }

    function disputeResult(
        address _rider, 
        address _driver, 
        uint _amount, 
        uint _riderVote, 
        uint _driverVote
        ) public {
                // DisputeInfo memory resolvedDispute = disputeInfoHolder[index];
            if (_riderVote > _driverVote) {
                // disputeInfo resolvedDispute = disputeInfoHolder[index];
                userBalances[_rider] = userBalances[_rider] + (_amount + _amount);
                // resolvedDispute.winner = 1;
            } else {
                // disputeInfo resolvedDispute = disputeInfoHolder[index];
                userBalances[_driver] = userBalances[_driver] + (_amount + _amount);
                // resolvedDispute.winner = 2;
            }
        
    }

    function getContractWorth() public view onlyOwner() returns (uint) {
        return moneySum;
    }

    function bookingLog(
        string memory bookingID, 
        string memory riderID, 
        string memory driverID, 
        string memory bookingTime, 
        string memory pickup, 
        string memory dropoff, 
        string memory status
        ) public {
        emit Booking(bookingID, riderID, driverID, bookingTime, pickup, dropoff, status);
    }

    function tripLog(
        string memory bookingID,
        string memory distance,
        string memory startTime,
        string memory endTime,
        // string memory duration,
        // string memory driverArrivalTime,
        // string memory waitTime,
        string memory total,
        string memory fuelCost,
        string memory waitTimeCostPerMin,
        string memory disputeCost,
        string memory waitTimeCost,
        string memory milesCost
        // string memory riderRating,
        // string memory driverRating
    ) public {
        emit Trip(
            bookingID, 
            distance, 
            startTime, 
            endTime, 
            total, 
            fuelCost, 
            waitTimeCostPerMin, 
            disputeCost, 
            waitTimeCost,
            milesCost
            );
    }

}