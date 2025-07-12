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
  late quill.QuillController quillController;

  @override
  void onInit() {
    super.onInit();
    quillController = quill.QuillController.basic();
  }

  @override
  void onClose() {
    title.dispose();
    tagText.dispose();
    quillController.dispose();
    super.onClose();
  }

  void addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag.trim())) {
      tags.add(tag.trim());
      tagText.clear();
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Title is required";
    }
    if (value.trim().length < 10) {
      return "Title must be at least 10 characters";
    }
    return null;
  }

  String? validateDescription() {
    final plainText = quillController.document.toPlainText().trim();
    if (plainText.isEmpty) {
      return "Description is required";
    }
    if (plainText.length < 20) {
      return "Description must be at least 20 characters";
    }
    return null;
  }

  String? validateTags() {
    if (tags.isEmpty) {
      return "At least one tag is required";
    }
    if (tags.length > 5) {
      return "Maximum 5 tags allowed";
    }
    return null;
  }

  Future<void> submitQuestion(String userId) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final plainText = quillController.document.toPlainText().trim();
    final delta = quillController.document.toDelta();

    // Validate description
    final descriptionError = validateDescription();
    if (descriptionError != null) {
      Get.snackbar("Error", descriptionError);
      return;
    }

    // Validate tags
    final tagError = validateTags();
    if (tagError != null) {
      Get.snackbar("Error", tagError);
      return;
    }

    isSubmitting.value = true;

    try {
      await FirebaseFirestore.instance.collection('questions').add({
        'title': title.text.trim(),
        'descriptionDelta': delta.toJson(), // Rich content
        'descriptionText': plainText,        // Plain text for preview/search
        'tags': tags.toList(),
        'author': FirebaseFirestore.instance.doc('users/$userId'),
        'answers': [],
        'acceptedAnswer': null,
        'upVotes': [],
        'downVotes': [],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Clear form
      title.clear();
      quillController.clear();
      tags.clear();

      Get.back();
      Get.snackbar(
        "Success",
        "Your question was posted successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to post question: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}