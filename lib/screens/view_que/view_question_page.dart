import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo/screens/homeScreen/home_screen.dart';
import 'package:odoo/screens/add_que/widgets/rich_text_editor.dart';

class ViewQuestionPage extends StatefulWidget {
  final Map<String, dynamic>? question;

  const ViewQuestionPage({
    Key? key,
    this.question,
  }) : super(key: key);

  @override
  State<ViewQuestionPage> createState() => _ViewQuestionPageState();
}

class _ViewQuestionPageState extends State<ViewQuestionPage> {
  final TextEditingController _answerController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSubmittingAnswer = false;

  // Sample question data (replace with actual data)
  late Map<String, dynamic> questionData;
  late List<Map<String, dynamic>> answers;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Initialize with sample data or passed question
    questionData = widget.question ?? {
      'id': '1',
      'title': 'How to implement authentication in Flutter with Firebase?',
      'description': 'I am trying to implement **Firebase Authentication** in my Flutter app. I want to support both *email/password* and *Google sign-in*.\n\nHere\'s what I\'ve tried:\n\n```dart\n// My current code\nFirebaseAuth.instance.signInWithEmailAndPassword(\n  email: email,\n  password: password,\n);\n```\n\nBut I\'m getting errors with Google sign-in. Can someone help?',
      'tags': ['flutter', 'firebase', 'authentication', 'google-signin'],
      'author': 'John Doe',
      'createdAt': '2024-01-15T10:30:00Z',
      'votes': 5,
      'views': 123,
      'answers': 2,
    };

    answers = [
      {
        'id': '1',
        'content': 'You need to add the **GoogleSignIn** package to your pubspec.yaml:\n\n```yaml\ndependencies:\n  google_sign_in: ^6.1.5\n  firebase_auth: ^4.10.1\n```\n\nThen implement it like this:\n\n```dart\nfinal GoogleSignIn _googleSignIn = GoogleSignIn();\n\nFuture<UserCredential> signInWithGoogle() async {\n  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();\n  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;\n\n  final credential = GoogleAuthProvider.credential(\n    accessToken: googleAuth?.accessToken,\n    idToken: googleAuth?.idToken,\n  );\n\n  return await FirebaseAuth.instance.signInWithCredential(credential);\n}\n```',
        'author': 'Jane Smith',
        'createdAt': '2024-01-15T11:45:00Z',
        'votes': 3,
        'isAccepted': true,
      },
      {
        'id': '2',
        'content': 'Also make sure to configure your **SHA-1 fingerprint** in Firebase Console:\n\n1. Go to Firebase Console\n2. Select your project\n3. Go to Project Settings\n4. Add your SHA-1 fingerprint\n\nYou can get your SHA-1 by running:\n```bash\nkeytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android\n```\n\nThis is a common issue that many developers face!',
        'author': 'Mike Johnson',
        'createdAt': '2024-01-15T14:20:00Z',
        'votes': 1,
        'isAccepted': false,
      }
    ];
  }

  @override
  void dispose() {
    _answerController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildMarkdownText(String text) {
    // Simple markdown rendering
    final lines = text.split('\n');
    List<Widget> widgets = [];
    bool inCodeBlock = false;
    List<String> codeLines = [];

    for (String line in lines) {
      if (line.trim().startsWith('```')) {
        if (inCodeBlock) {
          // End of code block
          widgets.add(
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                codeLines.join('\n'),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          );
          codeLines.clear();
          inCodeBlock = false;
        } else {
          // Start of code block
          inCodeBlock = true;
        }
        continue;
      }

      if (inCodeBlock) {
        codeLines.add(line);
        continue;
      }

      // Regular text processing
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      TextStyle style = const TextStyle(fontSize: 16, height: 1.5);
      String processedLine = line;

      // Handle inline code
      if (line.contains('`')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: RichText(
              text: TextSpan(
                style: style.copyWith(color: Colors.black),
                children: _buildInlineText(line),
              ),
            ),
          ),
        );
        continue;
      }

      // Handle bold text
      if (line.contains('**')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: RichText(
              text: TextSpan(
                style: style.copyWith(color: Colors.black),
                children: _buildInlineText(line),
              ),
            ),
          ),
        );
        continue;
      }

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(line, style: style),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  List<TextSpan> _buildInlineText(String text) {
    List<TextSpan> spans = [];
    final boldRegex = RegExp(r'\*\*(.*?)\*\*');
    final italicRegex = RegExp(r'\*(.*?)\*');
    final codeRegex = RegExp(r'`(.*?)`');

    String remainingText = text;
    int currentIndex = 0;

    while (currentIndex < text.length) {
      // Find the next formatting
      var boldMatch = boldRegex.firstMatch(remainingText);
      var italicMatch = italicRegex.firstMatch(remainingText);
      var codeMatch = codeRegex.firstMatch(remainingText);

      // Find the earliest match
      RegExpMatch? earliestMatch;
      String? matchType;

      if (boldMatch != null) {
        earliestMatch = boldMatch;
        matchType = 'bold';
      }
      if (italicMatch != null && (earliestMatch == null || italicMatch.start < earliestMatch.start)) {
        earliestMatch = italicMatch;
        matchType = 'italic';
      }
      if (codeMatch != null && (earliestMatch == null || codeMatch.start < earliestMatch.start)) {
        earliestMatch = codeMatch;
        matchType = 'code';
      }

      if (earliestMatch == null) {
        // No more formatting, add the rest as normal text
        spans.add(TextSpan(text: remainingText));
        break;
      }

      // Add text before the match
      if (earliestMatch.start > 0) {
        spans.add(TextSpan(text: remainingText.substring(0, earliestMatch.start)));
      }

      // Add the formatted text
      String matchedText = earliestMatch.group(1) ?? '';
      switch (matchType) {
        case 'bold':
          spans.add(TextSpan(
            text: matchedText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ));
          break;
        case 'italic':
          spans.add(TextSpan(
            text: matchedText,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ));
          break;
        case 'code':
          spans.add(TextSpan(
            text: matchedText,
            style: TextStyle(
              fontFamily: 'monospace',
              backgroundColor: Colors.grey.shade200,
              color: Colors.blue.shade800,
            ),
          ));
          break;
      }

      // Update remaining text
      remainingText = remainingText.substring(earliestMatch.end);
      currentIndex += earliestMatch.end;
    }

    return spans;
  }

  Future<void> _submitAnswer() async {
    if (_answerController.text.trim().isEmpty) {
      Get.snackbar(
        'Empty Answer',
        'Please write your answer before submitting.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade800,
      );
      return;
    }

    setState(() {
      _isSubmittingAnswer = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Add new answer to the list
      final newAnswer = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'content': _answerController.text.trim(),
        'author': 'Current User', // Replace with actual user
        'createdAt': DateTime.now().toIso8601String(),
        'votes': 0,
        'isAccepted': false,
      };

      setState(() {
        answers.add(newAnswer);
        _answerController.clear();
      });

      Get.snackbar(
        'Success!',
        'Your answer has been posted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
      );

      // Scroll to the new answer
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to post answer. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
    } finally {
      setState(() {
        _isSubmittingAnswer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StackIT'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.to(() => HomeScreen());
          },
          icon: const Icon(Icons.home),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Share functionality
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              // Bookmark functionality
            },
            icon: const Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Guidelines Card
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.amber.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Read the question carefully before answering. Provide clear, detailed solutions with code examples when possible.",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Question Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question Title
                    Text(
                      questionData['title'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Question Meta Info
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          questionData['author'],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(questionData['createdAt']),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Question Stats
                    Row(
                      children: [
                        _buildStatChip(Icons.thumb_up, questionData['votes'].toString(), Colors.green),
                        const SizedBox(width: 12),
                        _buildStatChip(Icons.visibility, questionData['views'].toString(), Colors.blue),
                        const SizedBox(width: 12),
                        _buildStatChip(Icons.question_answer, questionData['answers'].toString(), Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Question Description
                    _buildMarkdownText(questionData['description']),
                    const SizedBox(height: 16),

                    // Question Tags
                    Wrap(
                      spacing: 8,
                      children: (questionData['tags'] as List<String>).map((tag) {
                        return Chip(
                          label: Text(tag),
                          backgroundColor: Colors.blue.shade100,
                          labelStyle: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 12,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Answers Section
            Text(
              'Answers (${answers.length})',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Answer List
            ...answers.map((answer) => _buildAnswerCard(answer)).toList(),

            const SizedBox(height: 32),

            // Add Answer Section
            Text(
              'Your Answer',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            RichTextEditor(
              controller: _answerController,
              placeholder: 'Write your answer here...\n\n'
                  'Tips:\n'
                  '• Provide clear explanations\n'
                  '• Include code examples\n'
                  '• Test your solutions\n'
                  '• Be helpful and respectful',
              minHeight: 200,
            ),

            const SizedBox(height: 16),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isSubmittingAnswer ? null : _submitAnswer,
                icon: _isSubmittingAnswer
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.send),
                label: Text(
                  _isSubmittingAnswer ? 'Submitting...' : 'Submit Answer',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerCard(Map<String, dynamic> answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Answer Header
            Row(
              children: [
                if (answer['isAccepted']) ...[
                  Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Accepted Answer',
                    style: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                ],
                if (!answer['isAccepted']) const Spacer(),
                Text(
                  answer['author'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(answer['createdAt']),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Answer Content
            _buildMarkdownText(answer['content']),
            const SizedBox(height: 12),

            // Answer Actions
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Vote up
                  },
                  icon: const Icon(Icons.thumb_up_outlined),
                  iconSize: 20,
                ),
                Text(
                  answer['votes'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: () {
                    // Vote down
                  },
                  icon: const Icon(Icons.thumb_down_outlined),
                  iconSize: 20,
                ),
                const SizedBox(width: 16),
                TextButton.icon(
                  onPressed: () {
                    // Reply to answer
                  },
                  icon: const Icon(Icons.reply, size: 16),
                  label: const Text('Reply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}