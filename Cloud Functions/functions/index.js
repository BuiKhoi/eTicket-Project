const functions = require('firebase-functions');
const fb = require('firebase-admin');
fb.initializeApp();

exports.addUser = functions.https.onRequest(async (req, res) => {
  // // Grab the text parameter.
  // const original = req.query.text;
  // // Push the new message into the Realtime Database using the Firebase Admin SDK.
  // const snapshot = await admin.database().ref('/messages').push({original: original});
  // // Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
  // res.redirect(303, snapshot.ref.toString());
  var userId = req.query.id;
  fb.database().ref("Users/" + userId).set({
    Points: 0,
    Name: "Test"
  });
  res.send("User add ok");
});

exports.getUserTickets = functions.https.onRequest(async (req, res) => {
  var userId = req.query.id;
  fb.database().ref("Users/" + userId).once('value').then(function(snapshot) {
    var val = snapshot.val();
    console.log(val["Points"]);
    res.send(val["Points"].toString());
  });
});

exports.getUserName = functions.https.onRequest(async (req, res) => {
  var userId = req.query.id;
  fb.database().ref("Users/" + userId).once('value').then(function(snapshot) {
    var val = snapshot.val();
    console.log(val["Name"]);
    res.send(val["Name"].toString());
  });
});

exports.redeemCode = functions.https.onRequest(async (req, res) => {
  var code = req.query.code;
  var gbCode = code.substring(0, 4);
  console.log(gbCode);
  fb.database().ref("GarbageBin/" + gbCode).once('value').then(function(snapshot) {
    if (snapshot) {
      var gb = snapshot.val();
      if (gb["CGC"]) {
        if (gb["BinID"] == code) {
          fb.database().ref("GarbageBin/" + gbCode + "/CGC").set(false);
          addPoint(req.query.id);
          res.send("Redeemed");
          return;
        }
      }
    }
    res.send("Code Not Found");
  });
});

function addPoint(userId) {
  fb.database().ref("Users/" + userId).once('value').then(function(snapshot) {
      user = snapshot.val();
      point = user["Points"];
      point += 10;
      fb.database().ref("Users/" + userId + "/Points").set(point);
  });
}

exports.getRanking = functions.https.onRequest(async (req, res) => {
  var ranking = [];
  var users = [];
  fb.database().ref("Users").once('value').then(function(snapshot) {
    snapshot.forEach(function(child_snap) {
      var item = child_snap.val();
      users.push(item);
    })
    //console.log(users);
    users.sort(function(a, b) {
      return b["Points"] - a["Points"];
    });
    //console.log(users);
    res.send(JSON.stringify(users));
  });

});
