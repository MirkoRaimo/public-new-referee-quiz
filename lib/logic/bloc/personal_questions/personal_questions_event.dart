part of 'personal_questions_bloc.dart';

abstract class PersonalQuestionsEvent extends Equatable {
  const PersonalQuestionsEvent();

  @override
  List<Object> get props => [];
}

class AnswerQuestion extends PersonalQuestionsEvent {
  final int index;
  final int givenAnswer;

  AnswerQuestion(this.index, this.givenAnswer);

  @override
  List<Object> get props => [index];
}

class UpdateQuestions extends PersonalQuestionsEvent {
  final List<Question> updateQuestions;

  UpdateQuestions(this.updateQuestions);

  @override
  List<Object> get props => [updateQuestions];

  @override
  String toString() => 'UpdateQuestions { updateQuestion: $updateQuestions}';
}

class PLoadQuestions extends PersonalQuestionsEvent {}
