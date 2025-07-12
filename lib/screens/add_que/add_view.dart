import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo/screens/add_que/widgets/rich_text_editor.dart';
import 'package:odoo/screens/add_que/widgets/tag_input.dart';
import 'add_controller.dart';

class AskQuestionScreen extends StatelessWidget {
  final AskQuestionController controller = Get.find();
  final String currentUserId = "user123"; // Replace with real user ID from auth

  AskQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ask a Question"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ⚠️ Guidelines Card
              Card(
                color: Colors.amber.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb, color: Colors.amber.shade700),
                          const SizedBox(width: 8),
                          Text(
                            "Writing a Good Question",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "• Be specific and clear about your problem\n"
                            "• Include relevant code, error messages, or examples\n"
                            "• Use proper tags to help others find your question\n"
                            "• Search for existing questions before posting",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.amber.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 📝 Title Section
              Text(
                "Title",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.title,
                decoration: InputDecoration(
                  labelText: "What's your programming question?",
                  hintText: "e.g. How to implement authentication in Flutter?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: controller.validateTitle,
                maxLength: 150,
              ),

              const SizedBox(height: 24),

              /// 🧠 Rich Text Editor Section
              Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              RichTextEditor(
                controller: controller.quillController,
                placeholder: 'Describe your question in detail...\n\n'
                    'Include:\n'
                    '- What you\'ve tried\n'
                    '- Expected vs actual results\n'
                    '- Relevant code snippets\n'
                    '- Error messages',
                minHeight: 250,
              ),

              const SizedBox(height: 24),

              /// 🏷 Tag Input Section
              TagInputField(
                controller: controller.tagText,
                tags: controller.tags,
                onAddTag: controller.addTag,
                onRemoveTag: controller.removeTag,
                hintText: "e.g. flutter, firebase, dart",
                maxTags: 5,
              ),

              const SizedBox(height: 32),

              /// 🚀 Submit Button
              Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: controller.isSubmitting.value
                      ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.send),
                  label: Text(
                    controller.isSubmitting.value
                        ? "Posting Question..."
                        : "Post Your Question",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: controller.isSubmitting.value
                      ? null
                      : () => controller.submitQuestion(currentUserId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                ),
              )),

              const SizedBox(height: 16),

              /// Cancel Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}