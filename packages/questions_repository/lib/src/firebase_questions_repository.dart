import 'package:cloud_firestore/cloud_firestore.dart';

import 'entities/question_entity.dart';
import 'models/question.dart';
import 'questions_repository.dart';

class FirebaseQuestionsRepository implements QuestionsRepository {
  final questionCollection = FirebaseFirestore.instance.collection('questions');

  @override
  Future<void> addNewQuestion(Question question) {
    return questionCollection.add(question.toEntity().toDocument());
  }

  @override
  Future<void> deleteQuestion(Question question) async {
    return questionCollection.doc(question.id).delete();
  }

  @override
  Stream<List<Question>> questions() {
    return questionCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Question.fromEntity(QuestionEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateQuestion(Question update) {
    return questionCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}
