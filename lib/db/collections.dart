import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedFirestoreData() async {
  final firestore = FirebaseFirestore.instance;

  try {
    /// 1. Add User
    final userRef = await firestore.collection('users').add({
      'username': 'priyanshu_dev',
      'email': 'priyanshu@example.com',
      'password': 'hashed_password_123',
      'role': 'user',
      'banned': false,
      'notifications': [],
      'createdAt': FieldValue.serverTimestamp(),
    });

    /// 2. Add Question
    final questionRef = await firestore.collection('questions').add({
      'title': 'What is JWT and how does it work?',
      'description': 'Can someone explain JWT (JSON Web Token) in simple terms?',
      'tags': ['JWT', 'Auth', 'Security'],
      'author': userRef,
      'answers': [],
      'acceptedAnswer': null,
      'votes': [],
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    /// 3. Add Answer
    final answerRef = await firestore.collection('answers').add({
      'content': 'JWT is a compact way to represent claims between two parties securely.',
      'question': questionRef,
      'author': userRef,
      'votes': [],
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await questionRef.update({
      'answers': FieldValue.arrayUnion([answerRef])
    });

    /// 4. Add Notification
    await firestore.collection('notifications').add({
      'user': userRef,
      'type': 'answer',
      'message': 'Someone answered your question!',
      'link': '/questions/${questionRef.id}',
      'read': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    /// 5. Add Admin Action
    await firestore.collection('adminActions').add({
      'admin': userRef,
      'action': 'warn',
      'targetUser': userRef,
      'details': 'Inappropriate question flagged by moderator',
      'timestamp': FieldValue.serverTimestamp(),
    });

    print('✅ Firestore seed successful!');
  } catch (e) {
    print('❌ Error: $e');
  }
}
