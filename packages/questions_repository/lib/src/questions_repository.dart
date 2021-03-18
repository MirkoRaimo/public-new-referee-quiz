import 'models/question.dart';

abstract class QuestionsRepository {
  Future<void> addNewQuestion(Question question);

  Future<void> deleteQuestion(Question question);

  Stream<List<Question>> questions();

  Future<void> updateQuestion(Question question);
}
