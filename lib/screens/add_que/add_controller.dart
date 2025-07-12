import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AskQuestionController extends GetxController {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final tagsController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;

  Future<void> submitQuestion(String userId) async {
    if (!formKey.currentState!.validate()) return;

    isSubmitting.value = true;

    try {
      await FirebaseFirestore.instance.collection('questions').add({
        'title': titleController.text.trim(),
        'description': descController.text.trim(),
        'tags': tagsController.text.trim().split(',').map((tag) => tag.trim()).toList(),
        'author': FirebaseFirestore.instance.doc('users/$userId'),
        'answers': [],
        'acceptedAnswer': null,
        'votes': [],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("✅ Success", "Question posted!",
          snackPosition: SnackPosition.BOTTOM);
      Get.back();
    } catch (e) {
      Get.snackbar("❌ Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting.value = false;
    }
  }
}
