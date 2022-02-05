const cryptoJS = require("crypto-js");

exports.AES_encrypt = val => {
  const encryptedVal = cryptoJS.AES.encrypt(
    val,
    process.env.ENCRYPTION_SECRET_KEY
  ).toString();
  return encryptedVal;
};

exports.AES_decrypt = val => {
  const decryptedVal = cryptoJS.AES.decrypt(
    val,
    process.env.ENCRYPTION_SECRET_KEY
  ).toString(val.toString(CryptoJS.enc.Utf8));
  return decryptedVal;
};
