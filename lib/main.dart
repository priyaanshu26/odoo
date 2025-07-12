import 'package:odoo/screens/add_que/add_view.dart';
import 'package:odoo/utils/import_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StackIt',
      home: AskQuestionScreen(),
    );
  }
}




