import 'package:odoo/utils/import_export.dart';

void main() async {
  await FirebaseService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StackIt',
      home: Scaffold(
        appBar: AppBar(title: Text("StackIt - Seeding DB")),
        body: Center(child: Text("Seeding Firestore...")),
      ),
    );
  }
}
