const jwt = require("jsonwebtoken");
const { default: phone } = require("phone");
const { unAuthorizedResponse } = require("../helper/responses");

module.exports = (req, res, next) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const { phoneNumber } = req.body;
      const verify = jwt.verify(token, process.env.TOKEN_KEY);
      if (verify.phoneNumber !== phoneNumber) {
          throw new Error('Access denied')
      }
      
    next();
  } catch (error) {
      unAuthorizedResponse(res, 'UNAUTHORIZED_ACCESS');

  }
};
