const functions = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
admin.initializeApp();

// Helper to check admin
function isAdmin(context) {
  return context.auth && context.auth.token.role === "admin";
}

exports.createStudentAccount = functions.onCall(async (request) => {
  const context = request.context;
  const data = request.data;

  if (!isAdmin(context)) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only admins can create student accounts."
    );
  }

  const { email, name, course, yearLevel } = data;

  // Create user with default password
  const user = await admin.auth().createUser({
    email,
    password: "password",
  });

  // Assign student role
  await admin.auth().setCustomUserClaims(user.uid, { role: "student" });

  // Save student profile in Firestore
  await admin.firestore().collection("students").doc(user.uid).set({
    uid: user.uid,
    email,
    name,
    course,
    yearLevel,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { success: true, uid: user.uid };
});
