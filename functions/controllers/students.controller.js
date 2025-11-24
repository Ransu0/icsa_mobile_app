import admin from "firebase-admin";
import { onCall, HttpsError } from "firebase-functions/v2/https";

// CREATE student
export const createStudent = onCall(async (request) => {
  const data = request.data;

  const db = admin.firestore();
  const studentsRef = db.collection("students");

  const {
    firstname,
    lastname,
    middlename,
    suffix,
    program,
    section,
    yearLevel,
    student_id,
    email,
  } = data;

  if (
    !firstname ||
    !lastname ||
    !program ||
    !section ||
    !student_id ||
    !email ||
    !yearLevel
  ) {
    throw new HttpsError("invalid-argument", "Missing required fields.");
  }

  // Create auth user
  const user = await admin.auth().createUser({
    email,
    password: "password",
    role: "user",
  });

  // Create Firestore document
  await studentsRef.doc(user.uid).set({
    uid: user.uid,
    email,
    firstname,
    lastname,
    middlename: middlename ?? "",
    suffix: suffix ?? "",
    section,
    program,
    yearLevel,
    student_id,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { uid: user.uid };
});

// UPDATE student
export const updateStudent = onCall(async (request) => {
  const data = request.data;

  const db = admin.firestore();
  const studentsRef = db.collection("students");

  const { id, ...fields } = data;

  if (!id) {
    throw new HttpsError("invalid-argument", "Missing id.");
  }

  await studentsRef.doc(id).update({
    ...fields,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { success: true };
});

// DELETE student
export const deleteStudent = onCall(async (request) => {
  const { id } = request.data;

  const db = admin.firestore();
  const studentsRef = db.collection("students");

  if (!id) {
    throw new HttpsError("invalid-argument", "Missing id.");
  }

  await studentsRef.doc(id).delete();
  return { success: true };
});

// GET ALL students (Admin only)
export const getAllStudents = onCall(async (request) => {
  const context = request.auth;

  const db = admin.firestore();
  const studentsRef = db.collection("students");

  if (!context || context.token.role !== "admin") {
    throw new HttpsError(
      "permission-denied",
      "Only admins can read all students."
    );
  }

  const snapshot = await studentsRef.orderBy("firstname").get();

  const students = snapshot.docs.map((doc) => ({
    id: doc.id,
    ...doc.data(),
  }));

  return { students };
});
