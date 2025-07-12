import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo/screens/add_que/widgets/rich_text_editor.dart'; // Updated import
import 'package:odoo/screens/add_que/widgets/tag_input.dart';
import 'add_controller.dart';

class AskQuestionScreen extends StatelessWidget {
  final AskQuestionController controller = Get.put(AskQuestionController());
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
        actions: [
          // Optional: Add preview button
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () {
              _showPreviewDialog(context);
            },
            tooltip: 'Preview Question',
          ),
        ],
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
                            "• Search for existing questions before posting\n"
                            "• Use markdown formatting for better readability",
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
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  // Focus on description field when title is submitted
                  FocusScope.of(context).nextFocus();
                },
              ),

              const SizedBox(height: 24),

              /// 🧠 Simple Rich Text Editor Section
              Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              RichTextEditor(
                controller: controller.description,
                placeholder: 'Describe your question in detail...\n\n'
                    'Include:\n'
                    '• What you\'ve tried\n'
                    '• Expected vs actual results\n'
                    '• Relevant code snippets\n'
                    '• Error messages\n\n'
                    'Use the toolbar above to format your text!',
                minHeight: 250,
                onChanged: (value) {
                  // Optional: Auto-save on change
                  // controller.autoSave();
                },
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
                    _showCancelConfirmation(context);
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

  void _showPreviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question Preview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.title.text.isNotEmpty) ...[
                          Text(
                            controller.title.text,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (controller.description.text.isNotEmpty) ...[
                          Text(
                            controller.description.text,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (controller.tags.isNotEmpty) ...[
                          const Text(
                            'Tags:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: controller.tags.map((tag) {
                              return Chip(
                                label: Text(tag),
                                backgroundColor: Colors.blue.shade100,
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    // Check if there's any content
    bool hasContent = controller.title.text.isNotEmpty ||
        controller.description.text.isNotEmpty ||
        controller.tags.isNotEmpty;

    if (!hasContent) {
      Get.back();
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discard Question?'),
          content: const Text(
            'You have unsaved changes. Are you sure you want to discard this question?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Keep Editing'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.back();
              },
              child: const Text('Discard'),
            ),
          ],
        );
      },
    );
  }
}