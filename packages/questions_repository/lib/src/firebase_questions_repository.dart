import 'package:cloud_firestore/cloud_firestore.dart';

import 'entities/question_entity.dart';
import 'models/question.dart';
import 'questions_repository.dart';

final CollectionReference trueFalseCollection =
    FirebaseFirestore.instance.collection('true_false_questions');
final CollectionReference multiAnswCollection =
    FirebaseFirestore.instance.collection('multi_answ_questions');

class FirebaseQuestionsRepository implements QuestionsRepository {
  CollectionReference questionCollection;
  final QuestionType questionType;

  FirebaseQuestionsRepository(
      {this.questionCollection, this.questionType = QuestionType.TRUE_FALSE}) {
    if (questionType == QuestionType.TRUE_FALSE) {
      this.questionCollection = trueFalseCollection;
    } else {
      this.questionCollection = multiAnswCollection;
    }
  }

  @override
  Future<void> addNewQuestion(Question question) {
    if (question.trueFalseQuestion != null &&
        question.trueFalseQuestion == true) {
      questionCollection = trueFalseCollection;
    } else {
      questionCollection = multiAnswCollection;
    }
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
