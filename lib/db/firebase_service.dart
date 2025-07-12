// core/services/firebase_service.dart
import 'package:odoo/utils/import_export.dart';

class FirebaseService {
  static Future<void> init() async {
    await Firebase.initializeApp();
  }
}