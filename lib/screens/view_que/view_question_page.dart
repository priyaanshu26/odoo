import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:odoo/screens/homeScreen/home_screen.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

//
// void main() async {
//   // await FirebaseService.init();
//   runApp(const ViewQuestionPage());
// }
//
// class TempRun extends StatelessWidget {
//   const TempRun({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ViewQuestionPage(),
//     );
//   }
// }

class ViewQuestionPage extends StatelessWidget {
  const ViewQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StackIT'),
        leading: IconButton(
            onPressed: () {
              Get.to(() => HomeScreen());
            },
            icon: Icon(Icons.home)),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(bottom: 16),
            color: Colors.yellow.shade100,
            child: Text(
              "Make sure your question is clear and detailed. Use proper tags.",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Answers', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Text('Answer1'),
          Text('Content'),
          SizedBox(
            height: 20,
          ),
          Text('Answer2'),
          Text('Content'),
          SizedBox(
            height: 20,
          ),
          quill.QuillToolbar.basic(
            controller: controller.quillController,
            showAlignmentButtons: true,
            multiRowsDisplay: false,
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.all(8),
            child: quill.QuillEditor(
              controller: controller.quillController,
              readOnly: false,
              autoFocus: false,
              expands: false,
              focusNode: FocusNode(),
              scrollController: ScrollController(),
              scrollable: true,
              padding: EdgeInsets.zero,
              placeholder: "Start writing your question...",
              embedBuilders: quill.FlutterQuillEmbeds.builders(),
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: Text(
              'Submit',
              style: TextStyle(
                  backgroundColor: Colors.green, color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}
