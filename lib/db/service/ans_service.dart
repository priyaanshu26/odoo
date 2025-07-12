import 'package:odoo/utils/import_export.dart';

class AnswerService {
  final CollectionReference _answersRef =
  FirebaseFirestore.instance.collection('answers');

  /// Create a new answer and attach it to its question
  Future<void> createAnswer(AnsModule answer) async {
    try {
      DocumentReference newAnswerRef = await _answersRef.add(answer.toJson());

      // Update answer ID in Firestore (if needed)
      await newAnswerRef.update({KEY_ID: newAnswerRef.id});

      // Add answer ID to the question's answer list
      await FirebaseFirestore.instance
          .collection('questions')
          .doc(answer.que)
          .update({
        KEY_ANSWERS: FieldValue.arrayUnion([newAnswerRef.id])
      });
    } catch (e) {
      debugPrint("Error creating answer: $e");
    }
  }

  /// Get answer by ID
  Future<AnsModule?> getAnswer(String answerId) async {
    try {
      DocumentSnapshot doc = await _answersRef.doc(answerId).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        data[KEY_ID] = doc.id;
        return AnsModule.fromJson(data);
      }
    } catch (e) {
      debugPrint("Error fetching answer: $e");
    }
    return null;
  }

  /// Update an answer
  Future<void> updateAnswer(String answerId, AnsModule updatedAnswer) async {
    try {
      await _answersRef.doc(answerId).update(updatedAnswer.toJson());
    } catch (e) {
      debugPrint("Error updating answer: $e");
    }
  }

  /// Delete answer (also unlink from question)
  Future<void> deleteAnswer(String answerId, String questionId) async {
    try {
      await _answersRef.doc(answerId).delete();

      // Remove from parent question’s answer list
      await FirebaseFirestore.instance
          .collection('questions')
          .doc(questionId)
          .update({
        KEY_ANSWERS: FieldValue.arrayRemove([answerId])
      });
    } catch (e) {
      debugPrint("Error deleting answer: $e");
    }
  }

  /// Stream all answers for a specific question
  Stream<List<AnsModule>> streamAnswersForQuestion(String questionId) {
    return _answersRef
        .where(KEY_QUE, isEqualTo: questionId)
        .orderBy(KEY_CREATED_AT, descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data[KEY_ID] = doc.id;
        return AnsModule.fromJson(data);
      }).toList();
    });
  }

  /// Upvote logic
  Future<void> upvoteAnswer(String answerId, String userId) async {
    try {
      DocumentReference ref = _answersRef.doc(answerId);
      await FirebaseFirestore.instance.runTransaction((tx) async {
        DocumentSnapshot snap = await tx.get(ref);
        if (!snap.exists) return;

        var data = snap.data() as Map<String, dynamic>;
        List<String> upVotes = List<String>.from(data[KEY_UP_VOTES] ?? []);
        List<String> downVotes = List<String>.from(data[KEY_DOWN_VOTES] ?? []);

        if (upVotes.contains(userId)) {
          upVotes.remove(userId);
        } else {
          upVotes.add(userId);
          downVotes.remove(userId);
        }

        tx.update(ref, {
          KEY_UP_VOTES: upVotes,
          KEY_DOWN_VOTES: downVotes,
        });
      });
    } catch (e) {
      debugPrint("Error upvoting answer: $e");
    }
  }

  /// Downvote logic
  Future<void> downvoteAnswer(String answerId, String userId) async {
    try {
      DocumentReference ref = _answersRef.doc(answerId);
      await FirebaseFirestore.instance.runTransaction((tx) async {
        DocumentSnapshot snap = await tx.get(ref);
        if (!snap.exists) return;

        var data = snap.data() as Map<String, dynamic>;
        List<String> upVotes = List<String>.from(data[KEY_UP_VOTES] ?? []);
        List<String> downVotes = List<String>.from(data[KEY_DOWN_VOTES] ?? []);

        if (downVotes.contains(userId)) {
          downVotes.remove(userId);
        } else {
          downVotes.add(userId);
          upVotes.remove(userId);
        }

        tx.update(ref, {
          KEY_UP_VOTES: upVotes,
          KEY_DOWN_VOTES: downVotes,
        });
      });
    } catch (e) {
      debugPrint("Error downvoting answer: $e");
    }
  }
}
