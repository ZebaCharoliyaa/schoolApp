const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const cors = require("cors");

admin.initializeApp();
const db = admin.firestore();

const app = express();
app.use(cors({origin: true}));
app.use(express.json());

/* ===================== Middleware for Role-Based Access  */
const authenticateUser = async (req, res, next) => {
  try {
    const userId = req.headers["userid"];
    if (!userId) {
      return res.status(401).json({error: "User ID required"});
    }

    const userDoc = await db.collection("users").doc(userId).get();
    if (!userDoc.exists) {
      return res.status(403).json({error: "User not found"});
    }

    req.user = userDoc.data();
    next();
  } catch (error) {
    res.status(500).json({error: error.message});
  }
};

/* ===================== STUDENT APIs ===================== */
app.get("/students/:id", authenticateUser, async (req, res) => {
  try {
    if (
      req.user.role !== "student" &&
      req.user.role !== "teacher"
    ) {
      return res.status(403).json({error: "Unauthorized"});
    }

    const doc = await db.collection("students")
        .doc(req.params.id)
        .get();
    if (!doc.exists) {
      return res.status(404).json({error: "Student not found"});
    }

    res.status(200).json(doc.data());
  } catch (error) {
    res.status(500).json({error: error.message});
  }
});

/* ===================== TEACHER APIs ===================== */
app.post("/students", authenticateUser, async (req, res) => {
  try {
    if (req.user.role !== "teacher") {
      return res.status(403).json({
        error: "Only teachers can add students",
      });
    }

    const {name, attendance, homework} = req.body;
    const studentRef = await db.collection("students").add({
      name,
      attendance,
      homework,
    });

    res.status(201).json({
      message: "Student added",
      id: studentRef.id,
    });
  } catch (error) {
    res.status(500).json({error: error.message});
  }
});

/* ===================== PRINCIPAL APIs ===================== */
app.post("/teachers", authenticateUser, async (req, res) => {
  try {
    if (req.user.role !== "principal") {
      return res.status(403).json({
        error: "Only principals can add teachers",
      });
    }

    const {name, subjects} = req.body;
    const teacherRef = await db.collection("teachers").add({
      name,
      subjects,
    });

    res.status(201).json({
      message: "Teacher added",
      id: teacherRef.id,
    });
  } catch (error) {
    res.status(500).json({error: error.message});
  }
});

/* ===================== NOTICE APIs ===================== */
app.get("/notices", authenticateUser, async (req, res) => {
  try {
    const snapshot = await db.collection("notices").get();
    const notices = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    res.status(200).json(notices);
  } catch (error) {
    res.status(500).json({error: error.message});
  }
});

app.post("/notices", authenticateUser, async (req, res) => {
  try {
    if (
      req.user.role !== "teacher" &&
      req.user.role !== "principal"
    ) {
      return res.status(403).json({
        error: "Only teachers and principals can add notices",
      });
    }

    const {title, content} = req.body;
    const noticeRef = await db.collection("notices").add({
      title,
      content,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    res.status(201).json({
      message: "Notice added",
      id: noticeRef.id,
    });
  } catch (error) {
    res.status(500).json({error: error.message});
  }
});

exports.app = functions.https.onRequest(app);
