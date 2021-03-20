import 'models/question.dart';

enum QuestionType { MULTIPLE_ANSWERS, TRUE_FALSE }

abstract class QuestionsRepository {
  Future<void> addNewQuestion(Question question);

  Future<void> deleteQuestion(Question question);

  Stream<List<Question>> questions();

  Future<void> updateQuestion(Question question);
}
