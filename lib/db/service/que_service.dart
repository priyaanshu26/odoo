import 'package:odoo/utils/import_export.dart';

class QueService {
  final CollectionReference _quesRef =
  FirebaseFirestore.instance.collection('questions');

  /// Create a new question
  Future<void> createQuestion(QueModule question) async {
    try {
      await _quesRef.add(question.toJson());
    } catch (e) {
      debugPrint("Error creating question: $e");
    }
  }

  /// Get a single question by document ID
  Future<QueModule?> getQuestion(String questionId) async {
    try {
      DocumentSnapshot doc = await _quesRef.doc(questionId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data[KEY_ID] = questionId; // optional, if you need the doc ID
        return QueModule.fromJson(data);
      }
    } catch (e) {
      debugPrint("Error fetching question: $e");
    }
    return null;
  }

  /// Update an existing question
  Future<void> updateQuestion(String questionId, QueModule updatedQuestion) async {
    try {
      await _quesRef.doc(questionId).update(updatedQuestion.toJson());
    } catch (e) {
      debugPrint("Error updating question: $e");
    }
  }

  /// Delete a question
  Future<void> deleteQuestion(String questionId) async {
    try {
      await _quesRef.doc(questionId).delete();
    } catch (e) {
      debugPrint("Error deleting question: $e");
    }
  }

  /// Get real-time stream of all questions
  Stream<List<QueModule>> streamAllQuestions() {
    return _quesRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data[KEY_ID] = doc.id;
        return QueModule.fromJson(data);
      }).toList();
    });
  }

  /// Upvote a question
  Future<void> upvoteQuestion(String questionId, String userId) async {
    try {
      DocumentReference ref = _quesRef.doc(questionId);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(ref);
        if (!snapshot.exists) return;

        var data = snapshot.data() as Map<String, dynamic>;
        List<String> upVotes = List<String>.from(data[KEY_UP_VOTES] ?? []);
        List<String> downVotes = List<String>.from(data[KEY_DOWN_VOTES] ?? []);

        if (upVotes.contains(userId)) {
          upVotes.remove(userId);
        } else {
          upVotes.add(userId);
          downVotes.remove(userId);
        }

        transaction.update(ref, {
          KEY_UP_VOTES: upVotes,
          KEY_DOWN_VOTES: downVotes,
        });
      });
    } catch (e) {
      debugPrint("Error upvoting question: $e");
    }
  }

  /// Downvote a question
  Future<void> downvoteQuestion(String questionId, String userId) async {
    try {
      DocumentReference ref = _quesRef.doc(questionId);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(ref);
        if (!snapshot.exists) return;

        var data = snapshot.data() as Map<String, dynamic>;
        List<String> downVotes = List<String>.from(data[KEY_DOWN_VOTES] ?? []);
        List<String> upVotes = List<String>.from(data[KEY_UP_VOTES] ?? []);

        if (downVotes.contains(userId)) {
          downVotes.remove(userId);
        } else {
          downVotes.add(userId);
          upVotes.remove(userId);
        }

        transaction.update(ref, {
          KEY_UP_VOTES: upVotes,
          KEY_DOWN_VOTES: downVotes,
        });
      });
    } catch (e) {
      debugPrint("Error downvoting question: $e");
    }
  }

  /// Mark an answer as accepted
  Future<void> acceptAnswer(String questionId, String answerId) async {
    try {
      await _quesRef.doc(questionId).update({
        KEY_ACCEPTED_ANSWER: answerId,
      });
    } catch (e) {
      debugPrint("Error accepting answer: $e");
    }
  }

  /// Add answer ID to a question
  Future<void> addAnswerToQuestion(String questionId, String answerId) async {
    try {
      await _quesRef.doc(questionId).update({
        KEY_ANSWERS: FieldValue.arrayUnion([answerId])
      });
    } catch (e) {
      debugPrint("Error adding answer to question: $e");
    }
  }

  /// Remove answer ID from question (if deleted)
  Future<void> removeAnswerFromQuestion(String questionId, String answerId) async {
    try {
      await _quesRef.doc(questionId).update({
        KEY_ANSWERS: FieldValue.arrayRemove([answerId])
      });
    } catch (e) {
      debugPrint("Error removing answer from question: $e");
    }
  }
}
