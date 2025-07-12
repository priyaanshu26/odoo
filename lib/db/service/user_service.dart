import 'package:odoo/utils/import_export.dart';

class UserService {
    final CollectionReference _usersRef =
    FirebaseFirestore.instance.collection('users');

    /// Create a new user (use FirebaseAuth UID as doc ID if available)
    Future<void> createUser(UserModule user) async {
        _usersRef.add(user.toJson());
    }

    /// Get a single user by ID
    Future<UserModule?> getUser(String userId) async {
        try {
            DocumentSnapshot doc = await _usersRef.doc(userId).get();
            if (doc.exists) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                data['id'] = userId; // Set ID manually since it's not in the document fields
                return UserModule.fromJson(data);
            } else {
                return null;
            }
        } catch (e) {
            debugPrint('Error fetching user: $e');
            return null;
        }
    }

    /// Update an existing user
    Future<void> updateUser(UserModule user) async {
        if (user.id == null) {
            throw Exception("User ID is required for update");
        }

        await _usersRef.doc(user.id.toString()).update(user.toJson());
    }

    /// Delete a user by ID
    Future<void> deleteUser(String userId) async {
        await _usersRef.doc(userId).delete();
    }

    /// Get a real-time stream of all users
    Stream<List<UserModule>> streamAllUsers() {
        return _usersRef.snapshots().map((snapshot) {
            return snapshot.docs.map((doc) {
                var data = doc.data() as Map<String, dynamic>;
                data['id'] = doc.id;
                return UserModule.fromJson(data);
            }).toList();
        });
    }

    /// Ban or unban a user
    Future<void> setBannedStatus(String userId, bool banned) async {
        await _usersRef.doc(userId).update({'banned': banned});
    }

    /// Add a notification to a user
    Future<void> addNotification(String userId, dynamic notification) async {
        await _usersRef.doc(userId).update({
            'notifications': FieldValue.arrayUnion([notification])
        });
    }

    /// Mark all notifications as read (optional enhancement)
    Future<void> clearNotifications(String userId) async {
        await _usersRef.doc(userId).update({'notifications': []});
    }
}
