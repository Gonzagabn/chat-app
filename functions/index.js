const functions = require("firebase-functions");

exports.createMsg = functions.firestore
.document('chat/{msgId}')
.onCreate((snap, context) => {
    console.log(snap.data())
})
