import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:odoo/screens/add_que/add_view.dart';
import 'test/test_rich_text.dart'; // ✅ Make sure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AskQuestionScreen(), // ✅ This is now defined
    );
  }
}
