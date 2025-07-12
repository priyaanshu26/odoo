import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_controller.dart';

class AskQuestionScreen extends StatelessWidget {
  final AskQuestionController controller = Get.put(AskQuestionController());

  final String currentUserId = 'yourUserId'; // TODO: Get from auth controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ask a Question")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Title
                TextFormField(
                  controller: controller.titleController,
                  decoration: InputDecoration(labelText: "Title"),
                  validator: (val) =>
                  val == null || val.trim().isEmpty ? "Title required" : null,
                ),

                /// Description
                TextFormField(
                  controller: controller.descController,
                  decoration: InputDecoration(labelText: "Description"),
                  maxLines: 6,
                  validator: (val) =>
                  val == null || val.trim().isEmpty ? "Description required" : null,
                ),

                /// Tags
                TextFormField(
                  controller: controller.tagsController,
                  decoration: InputDecoration(labelText: "Tags (comma separated)"),
                  validator: (val) =>
                  val == null || val.trim().isEmpty ? "Add at least one tag" : null,
                ),

                SizedBox(height: 20),

                /// Submit Button
                Obx(() => ElevatedButton.icon(
                  onPressed: controller.isSubmitting.value
                      ? null
                      : () => controller.submitQuestion(currentUserId),
                  icon: Icon(Icons.send),
                  label: Text(controller.isSubmitting.value
                      ? "Posting..."
                      : "Post Question"),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
