const { setGlobalOptions } = require("firebase-functions/v2");
const { onValueCreated } = require("firebase-functions/v2/database");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

admin.initializeApp();

setGlobalOptions({ maxInstances: 10 });

// ✅ Utility: Send FCM Notification
const sendNotification = async (fcmToken, title, body) => {
  const payload = {
    notification: {
      title,
      body,
      sound: "default",
    },
  };
  try {
    await admin.messaging().sendToDevice(fcmToken, payload);
    console.log(`✅ Notification sent to ${fcmToken}`);
  } catch (error) {
    console.error("❌ Error sending notification:", error);
  }
};

// ✅ 🔔 Trigger: When a notice is added
exports.notifyOnNoticeAdd = onValueCreated("/notice_board/{noticeId}", async (event) => {
  const notice = event.data.val();
  const title = notice?.title || "New Notice";

  const studentsRef = admin.database().ref("students");
  const studentsSnapshot = await studentsRef.once("value");

  studentsSnapshot.forEach((standardSnap) => {
    standardSnap.forEach((studentSnap) => {
      const token = studentSnap.val().fcmToken;
      if (token) {
        sendNotification(token, "📢 New Notice", title);
      }
    });
  });

  return null;
});

// ✅ 📝 Trigger: When homework is added
exports.notifyOnHomeworkAdd = onValueCreated("/homework/{standard}/{subject}", async (event) => {
  const homework = event.data.val();
  const { standard, subject } = event.params;
  const title = homework?.title || "New Homework";

  const studentsRef = admin.database().ref(`students/${standard}`);
  const studentsSnapshot = await studentsRef.once("value");

  studentsSnapshot.forEach((studentSnap) => {
    const token = studentSnap.val().fcmToken;
    if (token) {
      sendNotification(token, `📚 ${title}`, `Subject: ${subject}`);
    }
  });

  return null;
});
