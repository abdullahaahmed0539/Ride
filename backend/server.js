const mongoose = require("mongoose");
const app = require("./app");
require("dotenv").config();


let MONGODB;
process.env.NODE_ENV === "development" 
  ? (MONGODB = "mongodb://127.0.0.1:27017/ride")
  : (MONGODB = process.env.MONGODB);

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
const PORT = process.env.PORT;
app.listen(PORT, () => {
  console.clear();
  console.log(`Running on port ${PORT}.`);
  console.log("Connecting to database...");
});
