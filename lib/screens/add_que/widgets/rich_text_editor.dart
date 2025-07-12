import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class RichTextEditor extends StatefulWidget {
  final QuillController controller;
  final String? placeholder;
  final double? minHeight;

  const RichTextEditor({
    Key? key,
    required this.controller,
    this.placeholder,
    this.minHeight = 200,
  }) : super(key: key);

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Toolbar
              QuillToolbar.simple(
                controller: widget.controller,
                configurations: QuillSimpleToolbarConfigurations(
                  multiRowsDisplay: false,
                  showAlignmentButtons: true,
                  showBackgroundColorButton: false,
                  showClearFormat: true,
                  showColorButton: true,
                  showCodeBlock: true,
                  showInlineCode: true,
                  showListNumbers: true,
                  showListBullets: true,
                  showListCheck: true,
                  showIndent: true,
                  showLink: true,
                  showUndo: true,
                  showRedo: true,
                  toolbarIconAlignment: WrapAlignment.start,
                  toolbarSectionSpacing: 4,
                ),
              ),
              // Editor
              Container(
                constraints: BoxConstraints(minHeight: widget.minHeight ?? 200),
                padding: const EdgeInsets.all(8),
                child: QuillEditor.basic(
                  controller: widget.controller,
                  configurations: QuillEditorConfigurations(
                    padding: const EdgeInsets.all(8),
                    placeholder: widget.placeholder ?? 'Start typing your question description...',
                    autoFocus: false,
                    expands: false,
                    scrollable: true,
                    showCursor: true,
                    readOnly: false,
                    customStyles: DefaultStyles(
                      paragraph: DefaultTextBlockStyle(
                        const TextStyle(fontSize: 16, height: 1.4),
                        HorizontalSpacing.zero,
                        VerticalSpacing.zero,
                        VerticalSpacing.zero,
                        null,
                      ),
                      h1: DefaultTextBlockStyle(
                        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        HorizontalSpacing.zero,
                        const VerticalSpacing(16, 0),
                        VerticalSpacing.zero,
                        null,
                      ),
                      h2: DefaultTextBlockStyle(
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        HorizontalSpacing.zero,
                        const VerticalSpacing(12, 0),
                        VerticalSpacing.zero,
                        null,
                      ),
                      h3: DefaultTextBlockStyle(
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        HorizontalSpacing.zero,
                        const VerticalSpacing(8, 0),
                        VerticalSpacing.zero,
                        null,
                      ),
                      code: DefaultTextBlockStyle(
                        TextStyle(
                          fontSize: 14,
                          fontFamily: 'monospace',
                          color: Colors.blue.shade800,
                          backgroundColor: Colors.grey.shade200,
                        ),
                        HorizontalSpacing.zero,
                        const VerticalSpacing(4, 0),
                        VerticalSpacing.zero,
                        null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}