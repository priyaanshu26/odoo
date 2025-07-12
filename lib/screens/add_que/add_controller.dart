import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AskQuestionController extends GetxController {
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController(); // Changed from QuillController
  final TextEditingController tagText = TextEditingController();

  // Observable variables
  var isSubmitting = false.obs;
  var tags = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add listener to description controller for real-time updates
    description.addListener(_onDescriptionChanged);
  }

  @override
  void onClose() {
    title.dispose();
    description.dispose();
    tagText.dispose();
    super.onClose();
  }

  void _onDescriptionChanged() {
    // This method is called whenever the description text changes
    // You can add auto-save functionality here if needed
  }

  // Title validation
  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a title for your question';
    }
    if (value.trim().length < 10) {
      return 'Title must be at least 10 characters long';
    }
    if (value.trim().length > 150) {
      return 'Title must be less than 150 characters';
    }
    return null;
  }

  // Description validation
  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please provide a description for your question';
    }
    if (value.trim().length < 20) {
      return 'Description must be at least 20 characters long';
    }
    return null;
  }

  // Add tag functionality
  void addTag(String tag) {
    if (tag.trim().isNotEmpty && !tags.contains(tag.trim().toLowerCase())) {
      if (tags.length < 5) {
        tags.add(tag.trim().toLowerCase());
        tagText.clear();
      } else {
        Get.snackbar(
          'Tag Limit Reached',
          'You can only add up to 5 tags',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.shade100,
          colorText: Colors.orange.shade800,
        );
      }
    }
  }

  // Remove tag functionality
  void removeTag(String tag) {
    tags.remove(tag);
  }

  // Get description text (for compatibility with old QuillController)
  String getDescriptionText() {
    return description.text;
  }

  // Get description as HTML (simple markdown to HTML conversion)
  String getDescriptionAsHtml() {
    String text = description.text;

    // Simple markdown to HTML conversion
    text = text.replaceAllMapped(RegExp(r'\*\*(.*?)\*\*'), (match) {
      return '<strong>${match.group(1)}</strong>';
    });

    text = text.replaceAllMapped(RegExp(r'\*(.*?)\*'), (match) {
      return '<em>${match.group(1)}</em>';
    });

    text = text.replaceAllMapped(RegExp(r'<u>(.*?)</u>'), (match) {
      return '<u>${match.group(1)}</u>';
    });

    text = text.replaceAllMapped(RegExp(r'`(.*?)`'), (match) {
      return '<code>${match.group(1)}</code>';
    });

    text = text.replaceAllMapped(RegExp(r'^# (.*?)$', multiLine: true), (match) {
      return '<h1>${match.group(1)}</h1>';
    });

    text = text.replaceAllMapped(RegExp(r'^## (.*?)$', multiLine: true), (match) {
      return '<h2>${match.group(1)}</h2>';
    });

    text = text.replaceAllMapped(RegExp(r'^### (.*?)$', multiLine: true), (match) {
      return '<h3>${match.group(1)}</h3>';
    });

    text = text.replaceAllMapped(RegExp(r'\[(.*?)\]\((.*?)\)'), (match) {
      return '<a href="${match.group(2)}">${match.group(1)}</a>';
    });

    // Convert newlines to <br> tags
    text = text.replaceAll('\n', '<br>');

    return text;
  }

  // Submit question
  Future<void> submitQuestion(String userId) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Validate description separately since it's not in the form
    if (validateDescription(description.text) != null) {
      Get.snackbar(
        'Validation Error',
        validateDescription(description.text)!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    if (tags.isEmpty) {
      Get.snackbar(
        'Tags Required',
        'Please add at least one tag to your question',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade800,
      );
      return;
    }

    isSubmitting.value = true;

    try {
      // Prepare question data
      Map<String, dynamic> questionData = {
        'title': title.text.trim(),
        'description': getDescriptionText(),
        'descriptionHtml': getDescriptionAsHtml(),
        'tags': tags.toList(),
        'userId': userId,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
        'votes': 0,
        'answers': 0,
        'views': 0,
        'status': 'open',
      };

      // TODO: Replace with your actual API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Success feedback
      Get.snackbar(
        'Success!',
        'Your question has been posted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
        duration: const Duration(seconds: 3),
      );

      // Clear form
      _clearForm();

      // Navigate back
      Get.back();

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to post question. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  // Clear form
  void _clearForm() {
    title.clear();
    description.clear();
    tagText.clear();
    tags.clear();
  }

  // Auto-save functionality (optional)
  void autoSave() {
    // You can implement auto-save to local storage here
    print('Auto-saving question...');
  }

  // Load draft (optional)
  void loadDraft() {
    // You can implement loading saved draft here
    print('Loading draft...');
  }
}