// import 'package:flutter_quill/flutter_quill.dart';
// import '../utils/import_export.dart';
//
// class RichTextEditor extends StatefulWidget {
//   @override
//   _RichTextEditorState createState() => _RichTextEditorState();
// }
//
// class _RichTextEditorState extends State<RichTextEditor> {
//   QuillController _controller = QuillController.basic();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         QuillToolbar.simple(controller: _controller),
//         Expanded(
//           child: QuillEditor.basic(
//             controller: _controller,
//             readOnly: false,
//           ),
//         ),
//       ],
//     );
//   }
// }