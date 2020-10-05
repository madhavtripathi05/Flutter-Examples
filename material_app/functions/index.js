const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// Simple req-res example
exports.helloFirebase = functions.https.onRequest((request, response) => {
  response.send(`Hello from Firebase! `);
});

const currentTime = () => {
  const currentDate = new Date();
  return (
    currentDate.getDate() +
    "/" +
    (currentDate.getMonth() + 1) +
    "/" +
    currentDate.getFullYear() +
    " @ " +
    currentDate.getHours() +
    ":" +
    currentDate.getMinutes() +
    ":" +
    currentDate.getSeconds()
  );
};

// using callable functions
exports.logCurrentUser = functions.https.onCall((data, context) => {
  const uid = data.uid;

  console.log(`user ${uid} logged in at ${currentTime()} `);
  return { msg: `Latest log-in on ${currentTime()}` };
});

// Function which automatically triggers when an event happens
exports.addEntry = functions.auth.user().onCreate((user) => {
  admin
    .firestore()
    .collection("logs")
    .doc(user.uid)
    .set({ log: `Latest log-in on ${currentTime}` });
});
