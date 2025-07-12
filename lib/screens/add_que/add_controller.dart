import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';

class AskQuestionController extends GetxController {
  final title = TextEditingController();
  final tagText = TextEditingController();
  final tags = <String>[].obs;
  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;

  // Rich Text Controller
  final quillController = quill.QuillController.basic();

  void addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag.trim())) {
      tags.add(tag.trim());
      tagText.clear();
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  Future<void> submitQuestion(String userId) async {
    final plainText = quillController.document.toPlainText().trim();
    final delta = quillController.document.toDelta();

    if (!formKey.currentState!.validate() || tags.isEmpty || plainText.isEmpty) {
      Get.snackbar("Incomplete", "Please fill all fields and add at least one tag.");
      return;
    }

    isSubmitting.value = true;

    try {
      await FirebaseFirestore.instance.collection('questions').add({
        'title': title.text.trim(),
        'descriptionDelta': delta.toJson(), // Rich content
        'descriptionText': plainText,        // Plain text for preview/search
        'tags': tags,
        'author': FirebaseFirestore.instance.doc('users/$userId'),
        'answers': [],
        'acceptedAnswer': null,
        'votes': [],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      Get.back();
      Get.snackbar("Success", "Your question was posted!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
