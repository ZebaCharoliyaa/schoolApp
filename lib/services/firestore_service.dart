// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   /// **📌 Add Student**
//   Future<void> addStudent({
//     required String name,
//     required String dob,
//     required String phone,
//     required String standard,
//   }) async {
//     await _addDocument(
//       collection: 'students',
//       data: {
//         'name': name,
//         'dob': dob,
//         'phone': phone,
//         'standard': standard,
//       },
//     );
//   }

//   /// **📌 Add Attendance**
//   Future<void> addAttendance({
//     required String studentId,
//     required String date,
//     required String status,
//   }) async {
//     await _addDocument(
//       collection: 'attendance',
//       data: {
//         'studentId': studentId,
//         'date': date,
//         'status': status,
//       },
//     );
//   }

//   /// **📌 Add Homework**
//   Future<void> addHomework({
//     required String studentId,
//     required String subject,
//     required String description,
//     required String dueDate,
//   }) async {
//     await _addDocument(
//       collection: 'homework',
//       data: {
//         'studentId': studentId,
//         'subject': subject,
//         'description': description,
//         'dueDate': dueDate,
//       },
//     );
//   }

//   /// **📌 Add Marksheet**
//   Future<void> addMarksheet({
//     required String studentId,
//     required String subject,
//     required int marks,
//   }) async {
//     await _addDocument(
//       collection: 'marksheet',
//       data: {
//         'studentId': studentId,
//         'subject': subject,
//         'marks': marks,
//       },
//     );
//   }

//   /// **📌 Add Notice**
//   Future<void> addNotice({
//     required String title,
//     required String content,
//   }) async {
//     await _addDocument(
//       collection: 'notices',
//       data: {
//         'title': title,
//         'content': content,
//         'date': DateTime.now().toIso8601String(),
//       },
//     );
//   }

//   /// **📌 Add Teacher (by Principal)**
//   Future<void> addTeacher({
//     required String name,
//     required String email,
//     required String phone,
//     required String subject,
//     required String principalId,
//   }) async {
//     await _addDocument(
//       collection: 'teachers',
//       data: {
//         'name': name,
//         'email': email,
//         'phone': phone,
//         'subject': subject,
//         'addedByPrincipal': principalId,
//       },
//     );
//   }

//   /// **📌 Get Teachers**
//   Future<List<Map<String, dynamic>>> getTeachers() async {
//     return await _getDocuments(collection: 'teachers');
//   }

//   /// **📌 Common Function to Add a Document**
//   Future<void> _addDocument({
//     required String collection,
//     required Map<String, dynamic> data,
//   }) async {
//     try {
//       await _db.collection(collection).add({
//         ...data,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       throw Exception('❌ Failed to add document to $collection: $e');
//     }
//   }

//   /// **📌 Common Function to Get Documents**
//   Future<List<Map<String, dynamic>>> _getDocuments({required String collection}) async {
//     try {
//       QuerySnapshot querySnapshot = await _db.collection(collection).get();
//       return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//     } catch (e) {
//       throw Exception('❌ Failed to fetch documents from $collection: $e');
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// **📌 Add Student**
  Future<void> addStudent({
    required String name,
    required String dob,
    required String phone,
    required String standard,
  }) {
    return _addDocument(
      collection: 'students',
      data: {
        'name': name,
        'dob': dob,
        'phone': phone,
        'standard': standard,
      },
    );
  }

  /// **📌 Add Attendance**
  Future<void> addAttendance({
    required String studentId,
    required String date,
    required String status,
  }) {
    return _addDocument(
      collection: 'attendance',
      data: {
        'studentId': studentId,
        'date': date,
        'status': status,
      },
    );
  }

  /// **📌 Add Homework**
  Future<void> addHomework({
    required String studentId,
    required String subject,
    required String description,
    required String dueDate,
  }) {
    return _addDocument(
      collection: 'homework',
      data: {
        'studentId': studentId,
        'subject': subject,
        'description': description,
        'dueDate': dueDate,
      },
    );
  }

  /// **📌 Add Marksheet**
  Future<void> addMarksheet({
    required String studentId,
    required String subject,
    required int marks,
  }) {
    return _addDocument(
      collection: 'marksheet',
      data: {
        'studentId': studentId,
        'subject': subject,
        'marks': marks,
      },
    );
  }

  /// **📌 Add Notice**
  Future<void> addNotice({
    required String title,
    required String content,
  }) {
    return _addDocument(
      collection: 'notices',
      data: {
        'title': title,
        'content': content,
        'date': DateTime.now().toIso8601String(),
      },
    );
  }

  /// **📌 Add Teacher (by Principal)**
  Future<void> addTeacher({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String principalId,
  }) {
    return _addDocument(
      collection: 'teachers',
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'subject': subject,
        'addedByPrincipal': principalId,
      },
    );
  }

  /// **📌 Get Teachers**
  Future<List<Map<String, dynamic>>> getTeachers() {
    return _getDocuments(collection: 'teachers');
  }

  /// **📌 Common Function to Add a Document**
  Future<void> _addDocument({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _db.collection(collection).add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("✅ Document added to $collection successfully!");
    } catch (e) {
      print("❌ Error adding document to $collection: $e");
      throw Exception('Failed to add document: $e');
    }
  }

  /// **📌 Common Function to Get Documents**
  Future<List<Map<String, dynamic>>> _getDocuments({required String collection}) async {
    try {
      QuerySnapshot querySnapshot = await _db.collection(collection).get();
      List<Map<String, dynamic>> documents =
          querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      print("✅ Retrieved ${documents.length} documents from $collection.");
      return documents;
    } catch (e) {
      print("❌ Error fetching documents from $collection: $e");
      throw Exception('Failed to fetch documents: $e');
    }
  }
}
