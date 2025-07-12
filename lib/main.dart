import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'db/collections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Important!
  runApp(MyApp());

  // Seed data
  seedFirestoreData(); // Call here after Firebase is ready
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StackIt',
      home: Scaffold(
        appBar: AppBar(title: Text("StackIt - Seeding DB")),
        body: Center(child: Text("Seeding Firestore.....")),
      ),
    );
  }
}
