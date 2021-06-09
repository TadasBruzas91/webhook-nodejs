const secret = process.env.GITHUB_PASSWD;
const dir = process.env.PROJECT_DIR;
const homeDir = process.env.HOME;
const repo = `${homeDir}/${dir}`;

const http = require("http");
const crypto = require("crypto");
const exec = require("child_process").exec;

http
  .createServer(function (req, res) {
    req.on("data", function (chunk) {
      let sig =
        "sha1=" +
        crypto
          .createHmac("sha1", secret)
          .update(chunk.toString())
          .digest("hex");

      if (req.headers["x-hub-signature"] == sig) {
        exec("cd " + repo + " && git pull");
        exec(`cd ${homeDir}/services/webhook-nodejs`);
        exec(`./build.sh`);
      }
    });

    res.end();
  })
  .listen(8080);
console.log(secret);
