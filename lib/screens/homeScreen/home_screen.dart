import 'package:flutter/material.dart';

void main() async {
  // await FirebaseService.init();
  runApp(const HomeScreen());
}

class TempRun extends StatelessWidget {
  const TempRun({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StackIt'),
        actions: [

          //LogIn button
          ElevatedButton(onPressed: () {

          },  child: Text('LogIn'))
        ],
      ),
      body: Column(
        children: [
          //search Bar and sort
          Row(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                controller: _searchController,
              )
            ],
          )
        ],
      ),
    );
  }
}
