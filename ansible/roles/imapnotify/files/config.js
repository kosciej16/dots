var child_process = require('child_process');

function getStdout(cmd) {
    var stdout = child_process.execSync(cmd);
    return stdout.toString().trim();
}

exports.host = "imap.gmail.com"
exports.port = 993;
exports.tls = true;
exports.tlsOptions = { "rejectUnauthorized": false };
exports.username = "kd305513@gmail.com";
exports.password = getStdout("pass apps/kd305513@gmail.com");
exports.onNotify = "mbsync home"
exports.onNotifyPost = {"mail": "/usr/bin/notmuch new && notify-send 'New mail arrived'"}
exports.boxes = ["INBOX"];
