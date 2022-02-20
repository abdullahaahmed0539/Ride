exports.serverErrorResponse = (res, err, SERVER_ERROR) => {
  res.status(500).json({
    request: "unsuccessful",
    error: {
      code: SERVER_ERROR,
      name: err.name,
      message: err.message,
      logs: err,
    },
    data: {},
  });
};

exports.notFoundResponse = (res, NOT_FOUND_ERROR, name, message) => {
  res.status(404).json({
    request: "unsuccessful",
    error: {
      code: NOT_FOUND_ERROR,
      name,
      message,
      logs: "",
    },
    data: {},
  });
};

exports.onCreationResponse = (res, data) => {
  res.status(201).json({
    request: "successful",
    error: {},
    data,
  });
};

exports.onMissingValResponse = (res, MISSING_VAL, message) => {
  res.status(406).json({
    request: "unsuccessful",
    error: {
      code: MISSING_VAL,
      name: "missingVal",
      message,
      logs: "",
    },
    data: {},
  });
};

exports.notUniqueResponse = (res, err, NOT_UNIQUE) => {
  res.status(406).json({
    request: "unsuccessful",
    error: {
      code: NOT_UNIQUE,
      name: err.name,
      message: err.message,
      logs: err.keyValue,
    },
    data: {},
  });
};

exports.incorrectFormatResponse = (res, INCORRECT_FORMAT, name, message) => {
  res.status(406).json({
    request: "unsuccessful",
    error: {
      code: INCORRECT_FORMAT,
      name,
      message,
      logs: "",
    },
    data: {},
  });
};

exports.successfulGetResponse = (res, data) => {
  res.status(200).json({
    request: "successful",
    error: {},
    data,
  });
};

exports.unAuthorizedResponse = (res, UNAUTHORIZED_ACCESS) => {
  res.status(401).json({
    request: "unsuccessful",
    error: {
      code: UNAUTHORIZED_ACCESS,
      name: "Unauthorized access.",
      message: "You do not have permission.",
      logs: "",
    },
    data: {},
  });
};

// exports.onBadParameters = (res, BAD_PARAMS) => {
//   res.status(401).json({
//     request: "unsuccessful",
//     error: {
//       code: BAD_PARAMS,
//       name: "ParamNotAcceptable.",
//       message: "Parameter value is not acceptable.",
//       logs: "",
//     },
//     data: {},
//   });
// };
