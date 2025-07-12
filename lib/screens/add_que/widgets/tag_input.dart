import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/ask_question_controller.dart';

class TagInputField extends StatelessWidget {
  final AskQuestionController controller;

  const TagInputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tags (press enter after each)", style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller.tagText,
          onSubmitted: controller.addTag,
          decoration: InputDecoration(
            hintText: "e.g. flutter, firebase, auth",
            suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => controller.addTag(controller.tagText.text),
            ),
          ),
        ),
        Obx(() => Wrap(
          spacing: 8.0,
          children: controller.tags.map((tag) {
            return Chip(
              label: Text(tag),
              onDeleted: () => controller.removeTag(tag),
            );
          }).toList(),
        )),
      ],
    );
  }
}
