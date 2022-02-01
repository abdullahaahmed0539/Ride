const User = require("../../models/Users");

exports.register = (req, res) => {
    const { phoneNumber, country, firstName, lastName, email, walletAddress } = req.body;
    
};