import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagInputField extends StatelessWidget {
  final TextEditingController controller;
  final RxList<String> tags;
  final Function(String) onAddTag;
  final Function(String) onRemoveTag;
  final String? hintText;
  final int maxTags;

  const TagInputField({
    Key? key,
    required this.controller,
    required this.tags,
    required this.onAddTag,
    required this.onRemoveTag,
    this.hintText,
    this.maxTags = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Tags",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            Obx(() => Text(
              "(${tags.length}/$maxTags)",
              style: TextStyle(
                color: tags.length >= maxTags ? Colors.red : Colors.grey,
                fontSize: 12,
              ),
            )),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              onAddTag(value.trim());
            }
          },
          decoration: InputDecoration(
            hintText: hintText ?? "e.g. flutter, firebase, dart (press Enter to add)",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      onAddTag(controller.text.trim());
                    }
                  },
                ),
                if (controller.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                    },
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(() => tags.isEmpty
            ? Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                "Add at least one tag to categorize your question",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )
            : Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: tags.map((tag) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue.shade200),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Chip(
                label: Text(
                  tag,
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 12,
                  ),
                ),
                backgroundColor: Colors.transparent,
                deleteIconColor: Colors.blue.shade700,
                onDeleted: () => onRemoveTag(tag),
                elevation: 0,
                side: BorderSide.none,
              ),
            );
          }).toList(),
        )),
        if (tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 16),
                const SizedBox(width: 4),
                Text(
                  "Tags added successfully",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}