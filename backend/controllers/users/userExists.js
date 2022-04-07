const { onMissingValResponse, successfulGetResponse, serverErrorResponse } = require('../../helper/responses');
const User = require('../../models/Users')

exports.userExists = async (req, res) => {
    const { phoneNumber } = req.body;
    if (!phoneNumber) {
        onMissingValResponse(res, 'MISSING_VAL', 'Phone number missing.')
        return
    }

    try {
        const user = await User.findOne({ phoneNumber });
        let data = {};
        user ? data = { exists: true } : data = { exists: false }
        successfulGetResponse(res, data);
    } catch (err) {
        serverErrorResponse(res, err, 'INTERNAL_SERVER_ERROR')
    }
}