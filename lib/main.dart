import 'package:odoo/screens/add_que/add_view.dart';
import 'package:odoo/screens/homeScreen/home_screen.dart';
import 'package:odoo/screens/loginScreen/loginScreen.dart';
import 'package:odoo/utils/import_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StackIt',
      home: HomeScreen(),
    );
  }
}




