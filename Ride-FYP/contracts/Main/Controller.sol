pragma solidity ^0.8.0;

import "Ride-FYP/contracts/Main/rideToken.sol";
import "Ride-FYP/contracts/Main/investorToken.sol";

contract Controller {

    rideToken coins;
    investorToken stocks;
    address watcher;
    address vault;
    uint collatForDriver;
    mapping (address => uint) collatAmount;

    constructor() public {
        // coins = RideToken(<Address of ERC20 tokens>);
        coins = RideToken(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2); //THIS IS WETH ADDRESS BEING USED FOR TESTING TILL OUR ERC20 IS READY 
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

    function collectCollatFromDriver(uint calldata _amount) external payable { //At the moment, the collateral will be saved in the form of our Ride Coins
        require(_amount >= collatForDriver, "Insufficient amount.");
        coins.approve(vault, _amount);
        coins.transferFrom(msg.sender, vault, _amount);
        collatAmount(msg.sender) = _amount;

    }

    function giveAllCollatToDriver(address calldata _driver) external {
        require(driver == msg.sender, "Please specify your valid wallet address.");
        coins.transferFrom(vault, msg.sender, collatAmount(msg.sender));
        collatAmount(msg.sender) = 0;

    }

    function giveCollatToDriver(address calldata _driver, uint calldata _amount) external {
        require(driver == msg.sender, "Please specify your valid wallet address.");
        require(_amount <= collatAmount(msg.sender), "Insufficient amount held in balance.");
        _amount = collatAmount(msg.sender) - _amount;
        coins.transferFrom(vault, msg.sender, _amount);
        collatAmount(msg.sender) = 0;

    }

    function setAmountForCollat(uint amount) private onlyOwner { //Allow admin to adjust the collateral amount
        require(msg.sender == watcher, "Only the admin can set this value.");
        // collatForDriver = amount * (1 ether);
        collatForDriver = amount;
    }

    function startRideDriver() public { 

    }

    function endRideDriver() public {

    }
    //Collect Collateral from Driver
    //Allow rides to happen
    //Allow people to buy Ride Tokens
    //Allow people to buy Stock/NFT
    //Allow the voting to take place
    //Handle mapping for Address > Name
    //View functions for reading different things like Balance/Owner
    //Extra info will be kept in the Database. This includes location and cost of ride.
    //Decide what to save on-chain. This may include voting related data.

}