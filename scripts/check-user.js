#!/usr/bin/env node
import dotenv from 'dotenv';
dotenv.config();
import admin from 'firebase-admin';
import fs from 'fs';

function initAdmin() {
  if (admin.apps.length) return;

  // Prefer Application Default Credentials if GOOGLE_APPLICATION_CREDENTIALS is set
  const adcPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;
  if (adcPath && fs.existsSync(adcPath)) {
    admin.initializeApp({ credential: admin.credential.applicationDefault() });
    return;
  }

  // Fallback to explicit service account from env vars
  const { FIREBASE_PROJECT_ID, FIREBASE_CLIENT_EMAIL, FIREBASE_PRIVATE_KEY } = process.env;
  if (FIREBASE_PROJECT_ID && FIREBASE_CLIENT_EMAIL && FIREBASE_PRIVATE_KEY) {
    admin.initializeApp({
      credential: admin.credential.cert({
        projectId: FIREBASE_PROJECT_ID,
        clientEmail: FIREBASE_CLIENT_EMAIL,
        privateKey: FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
      }),
    });
    return;
  }

  console.error('Missing Firebase credentials. Set GOOGLE_APPLICATION_CREDENTIALS or FIREBASE_PROJECT_ID/FIREBASE_CLIENT_EMAIL/FIREBASE_PRIVATE_KEY');
  process.exit(1);
}

const [, , identifier] = process.argv;
if (!identifier) {
  console.error('Usage: node scripts/check-user.js <uid|email>');
  process.exit(1);
}

initAdmin();

(async () => {
  try {
    let uid = identifier;
    if (identifier.includes('@')) {
      const userRecord = await admin.auth().getUserByEmail(identifier);
      uid = userRecord.uid;
      console.log(`Resolved email ${identifier} -> uid ${uid}`);
    }

    const ref = admin.firestore().doc(`users/${uid}`);
    const snap = await ref.get();
    if (!snap.exists) {
      console.log(`Document users/${uid} not found.`);
      process.exit(2);
    }

    console.log(`Document users/${uid}:`);
    console.log(JSON.stringify(snap.data(), null, 2));
    process.exit(0);
  } catch (err) {
    console.error('Error while checking user:', err.message || err);
    process.exit(3);
  }
})();
