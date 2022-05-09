const User = require('../../models/Users')
const { onMissingValResponse, successfulGetResponse, serverErrorResponse } = require('../../helper/responses');
const { errorCodes } = require("../../helper/errorCodes");

exports.userExists = async (req, res) => {
    const { phoneNumber } = req.body;
    if (!phoneNumber) {
        onMissingValResponse(res, errorCodes.MISSING_VAL, 'Phone number missing.')
        return
    }

    try {
        const user = await User.findOne({ phoneNumber });
        let data = {};
        user ? data = { exists: true } : data = { exists: false }
        successfulGetResponse(res, data);
    } catch (err) {
        serverErrorResponse(res, err, errorCodes.SERVER_ERROR)
    }
}