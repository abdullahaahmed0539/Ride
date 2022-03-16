const aws = require("aws-sdk");
const dotenv = require("dotenv");
const crypto = require("crypto");
const { promisify } = require("util");
const { onCreationResponse, serverErrorResponse } = require("./responses");

dotenv.config();
const randomBytes = promisify(crypto.randomBytes);

exports.uploadImage = async document => {
  const region = process.env.AWS_REGION;
  const bucketName = process.env.AWS_BUCKET_NAME;
  const accessKeyId = process.env.AWS_ACCESS_KEY_ID;
  const secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY;

  const s3 = new aws.S3({
    region,
    accessKeyId,
    secretAccessKey,
    signatureVersion: "v4",
  });

  const rawBytes = await randomBytes(16);
  const imageName = rawBytes.toString("hex");
  const params = {
    Bucket: bucketName,
    Key: `${document}/${imageName}`,
    Expires: 60,
  };

  try {
    const uploadURL = await s3.getSignedUrlPromise("putObject", params);
    onCreationResponse(res, { uploadURL });
  } catch (err) {
    serverErrorResponse(res, err, "INTERNAL_SERVER_ERROR");
  }
};
