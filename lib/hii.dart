import 'package:flutter/material.dart';


class Hii extends StatefulWidget {
  const Hii({super.key});

  @override
  State<Hii> createState() => _HiiState();
}

class _HiiState extends State<Hii> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hii"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Text("Hii"),
          Text("Hii"),
          Text("Hii"),
          Text("Hii"),
          Text("Hii"),
          Form(
              child: Column(
                children: [
                  TextFormField(),
                  TextFormField(),
                  TextFormField(),
                  TextFormField(),
                  TextFormField(),
                ],
              )
          )
        ],
      ),
    );
  }
}
