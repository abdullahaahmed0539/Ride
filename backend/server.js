const mongoose = require("mongoose");
const app = require("./app");
require('dotenv').config()

const MONGODB = process.env.MONGODB;

mongoose
  .connect(MONGODB, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    process.stdout.write("Database connection:");
    console.log("\x1b[32m", "SUCCESS");
    console.log("\x1b[0m", `\n`);
    
  })
  .catch(err => {
    process.stdout.write("Database connection:");
    console.log("\x1b[31m", "UNSUCCESS");
    console.log("\x1b[0m", `Error log: ${err}\n`);
  });

//Starting up server
const PORT = 5000;
app.listen(PORT, () => {
  console.clear();
  console.log(`Running on port ${PORT}.`);
  console.log("Connecting to database...");
});
