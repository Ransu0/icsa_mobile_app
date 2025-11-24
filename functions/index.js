import admin from "firebase-admin";
import { onCall } from "firebase-functions/v2/https";

admin.initializeApp();

import {
  createStudent,
  updateStudent,
  deleteStudent,
  getAllStudents,
} from "./controllers/students.controller.js";

export const createStudentAccount = createStudent;
export const updateStudentAccount = updateStudent;
export const deleteStudentAccount = deleteStudent;
export const listStudents = getAllStudents;

export const sayHello = onCall((request) => {
  const name = request.data?.name || "Guest";
  return { message: `Hello, ${name}!` };
});
