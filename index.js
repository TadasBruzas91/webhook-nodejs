const secret = "password"; // Password from GitHub Webhook
const dir = "code/crypto-prices";
const homeDir = process.env.HOME;
const repo = `${homeDir}/${dir}`; // Repository path

const http = require("http");
const crypto = require("crypto");
const exec = require("child_process").exec;
const port = 8080;

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
        exec(
          `cd ${repo} && git pull && cd ${homeDir}/services/webhook-nodejs && ./build.sh && echo Last build - $(date) >> gitLog.txt`
        );
      }
    });

    res.end();
  })
  .listen(port);
