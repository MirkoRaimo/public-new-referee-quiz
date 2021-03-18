part of 'questions_bloc.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}

class LoadQuestions extends QuestionsEvent {}

class AddQuestion extends QuestionsEvent {
  final Question question;

  const AddQuestion(this.question);

  @override
  List<Object> get props => [question];

  @override
  String toString() => 'AddQuestion { question: $question }';
}

class UpdateQuestion extends QuestionsEvent {
  final Question updatedQuestion;

  const UpdateQuestion(this.updatedQuestion);

  @override
  List<Object> get props => [updatedQuestion];

  @override
  String toString() => 'UpdateQuestion { updatedQuestion: $updatedQuestion }';
}

class DeleteQuestion extends QuestionsEvent {
  final Question question;

  const DeleteQuestion(this.question);

  @override
  List<Object> get props => [question];

  @override
  String toString() => 'DeleteQuestion { question: $question }';
}

class QuestionsUpdated extends QuestionsEvent {
  final List<Question> questions;

  const QuestionsUpdated(this.questions);

  @override
  List<Object> get props => [questions];
}
