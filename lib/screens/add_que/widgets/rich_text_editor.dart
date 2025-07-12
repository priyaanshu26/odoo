import 'package:flutter/material.dart';

class RichTextEditor extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final double? minHeight;
  final Function(String)? onChanged;

  const RichTextEditor({
    Key? key,
    required this.controller,
    this.placeholder,
    this.minHeight = 200,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  final FocusNode _focusNode = FocusNode();
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  bool _isCode = false;
  TextAlign _textAlign = TextAlign.left;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _insertText(String text) {
    final currentText = widget.controller.text;
    final selection = widget.controller.selection;

    final newText = currentText.replaceRange(
      selection.start,
      selection.end,
      text,
    );

    widget.controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selection.start + text.length,
      ),
    );
  }

  void _wrapSelectedText(String prefix, String suffix) {
    final selection = widget.controller.selection;
    final text = widget.controller.text;

    if (selection.isValid) {
      final selectedText = text.substring(selection.start, selection.end);
      final wrappedText = '$prefix$selectedText$suffix';

      final newText = text.replaceRange(selection.start, selection.end, wrappedText);

      widget.controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection(
          baseOffset: selection.start + prefix.length,
          extentOffset: selection.start + prefix.length + selectedText.length,
        ),
      );
    }
  }

  void _insertBulletPoint() {
    final selection = widget.controller.selection;
    final text = widget.controller.text;

    // Find the start of the current line
    int lineStart = selection.start;
    while (lineStart > 0 && text[lineStart - 1] != '\n') {
      lineStart--;
    }

    // Insert bullet point at the beginning of the line
    final newText = text.replaceRange(lineStart, lineStart, '• ');

    widget.controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.start + 2),
    );
  }

  void _insertNumberedList() {
    final selection = widget.controller.selection;
    final text = widget.controller.text;

    // Find the start of the current line
    int lineStart = selection.start;
    while (lineStart > 0 && text[lineStart - 1] != '\n') {
      lineStart--;
    }

    // Insert numbered point at the beginning of the line
    final newText = text.replaceRange(lineStart, lineStart, '1. ');

    widget.controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.start + 3),
    );
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
              // Simple Toolbar
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Wrap(
                  spacing: 4,
                  children: [
                    // Bold
                    _ToolbarButton(
                      icon: Icons.format_bold,
                      isSelected: _isBold,
                      onPressed: () {
                        setState(() {
                          _isBold = !_isBold;
                        });
                        _wrapSelectedText('**', '**');
                      },
                      tooltip: 'Bold',
                    ),

                    // Italic
                    _ToolbarButton(
                      icon: Icons.format_italic,
                      isSelected: _isItalic,
                      onPressed: () {
                        setState(() {
                          _isItalic = !_isItalic;
                        });
                        _wrapSelectedText('*', '*');
                      },
                      tooltip: 'Italic',
                    ),

                    // Underline
                    _ToolbarButton(
                      icon: Icons.format_underlined,
                      isSelected: _isUnderline,
                      onPressed: () {
                        setState(() {
                          _isUnderline = !_isUnderline;
                        });
                        _wrapSelectedText('<u>', '</u>');
                      },
                      tooltip: 'Underline',
                    ),

                    const SizedBox(width: 8),

                    // Code
                    _ToolbarButton(
                      icon: Icons.code,
                      isSelected: _isCode,
                      onPressed: () {
                        setState(() {
                          _isCode = !_isCode;
                        });
                        _wrapSelectedText('`', '`');
                      },
                      tooltip: 'Code',
                    ),

                    const SizedBox(width: 8),

                    // Bullet List
                    _ToolbarButton(
                      icon: Icons.format_list_bulleted,
                      onPressed: _insertBulletPoint,
                      tooltip: 'Bullet List',
                    ),

                    // Numbered List
                    _ToolbarButton(
                      icon: Icons.format_list_numbered,
                      onPressed: _insertNumberedList,
                      tooltip: 'Numbered List',
                    ),

                    const SizedBox(width: 8),

                    // Heading 1
                    _ToolbarButton(
                      icon: Icons.title,
                      onPressed: () {
                        _wrapSelectedText('# ', '');
                      },
                      tooltip: 'Heading 1',
                    ),

                    // Heading 2
                    _ToolbarButton(
                      icon: Icons.format_size,
                      onPressed: () {
                        _wrapSelectedText('## ', '');
                      },
                      tooltip: 'Heading 2',
                    ),

                    const SizedBox(width: 8),

                    // Link
                    _ToolbarButton(
                      icon: Icons.link,
                      onPressed: () {
                        _wrapSelectedText('[', '](url)');
                      },
                      tooltip: 'Link',
                    ),

                    // Code Block
                    _ToolbarButton(
                      icon: Icons.code_off,
                      onPressed: () {
                        _insertText('\n```\n\n```\n');
                      },
                      tooltip: 'Code Block',
                    ),
                  ],
                ),
              ),

              // Text Editor
              Container(
                constraints: BoxConstraints(minHeight: widget.minHeight ?? 200),
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  maxLines: null,
                  minLines: 8,
                  onChanged: widget.onChanged,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.placeholder ?? 'Start typing your question description...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Formatting Help
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Tip: Use markdown syntax for formatting. Selected text will be wrapped with formatting codes.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSelected;
  final String tooltip;

  const _ToolbarButton({
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: isSelected ? Colors.blue.shade100 : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.blue.shade700 : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}