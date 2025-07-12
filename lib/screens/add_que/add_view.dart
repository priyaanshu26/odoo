import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'add_controller.dart';

class AskQuestionScreen extends StatelessWidget {
  final AskQuestionController controller = Get.find();
  final String currentUserId = "user123"; // Replace with real user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ask a Question")),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              /// ⚠️ Warning
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 16),
                color: Colors.yellow.shade100,
                child: Text(
                  "Make sure your question is clear and detailed. Use proper tags.",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              /// 📝 Title
              TextFormField(
                controller: controller.title,
                decoration: InputDecoration(labelText: "Title"),
                validator: (val) =>
                val == null || val.trim().isEmpty ? "Title is required" : null,
              ),

              SizedBox(height: 16),

              /// 🧠 Rich Text Editor
              Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
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

              SizedBox(height: 20),

              /// 🏷 Tag Input
              Text("Tags", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: controller.tagText,
                decoration: InputDecoration(
                  hintText: "e.g. flutter, firebase, auth",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => controller.addTag(controller.tagText.text),
                  ),
                ),
                onSubmitted: controller.addTag,
              ),
              Obx(() => Wrap(
                spacing: 8,
                children: controller.tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () => controller.removeTag(tag),
                  );
                }).toList(),
              )),

              SizedBox(height: 24),

              /// 🚀 Submit Button
              Obx(() => ElevatedButton.icon(
                icon: Icon(Icons.send),
                label: Text(controller.isSubmitting.value
                    ? "Posting..."
                    : "Post Question"),
                onPressed: controller.isSubmitting.value
                    ? null
                    : () => controller.submitQuestion(currentUserId),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
