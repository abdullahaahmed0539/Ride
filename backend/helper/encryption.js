const CryptoJs = require("crypto-js");

exports.AES_encrypt = val => {
  const encryptedVal = CryptoJs.AES.encrypt(
    val,
    process.env.ENCRYPTION_SECRET_KEY
  ).toString();
  return encryptedVal;
};

exports.AES_decrypt = val => {
  const decryptedVal = CryptoJs.AES.decrypt(
    val,
    process.env.ENCRYPTION_SECRET_KEY
  ).toString(val.toString(CryptoJs.enc.Utf8));
  return decryptedVal;
};

exports.SHA3 = val => {
  return CryptoJs.SHA3(val);
};
