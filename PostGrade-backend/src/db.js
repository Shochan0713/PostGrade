// src/db.js
const admin = require('firebase-admin');
const serviceAccount = require('./config/serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://postgrade-b487e-default-rtdb.firebaseio.com/"
});

const db = admin.firestore();
module.exports = db;