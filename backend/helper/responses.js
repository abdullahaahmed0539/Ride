exports.serverErrorResponse = (err, SERVER_ERROR) => {
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
