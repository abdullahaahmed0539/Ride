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
