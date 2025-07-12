import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class RichTextEditor extends StatelessWidget {
  final QuillController controller;

  const RichTextEditor({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuillToolbar.basic(
          controller: controller,
          showAlignmentButtons: true,
          multiRowsDisplay: false,
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(6),
          ),
          constraints: BoxConstraints(minHeight: 200),
          child: QuillEditor(
            controller: controller,
            readOnly: false,
            autoFocus: false,
            expands: false,
            focusNode: FocusNode(),
            scrollController: ScrollController(),
            padding: EdgeInsets.zero,
            scrollable: true,
            showCursor: true,
            placeholder: 'Start typing your question description...',
            customStyles: DefaultStyles(
              paragraph: DefaultTextBlockStyle(
                TextStyle(fontSize: 16),
                const Tuple2(8, 0),
                const Tuple2(0, 0),
                null,
              ),
            ),
            embedBuilders: FlutterQuillEmbeds.builders(),
          ),
        ),
      ],
    );
  }
}
