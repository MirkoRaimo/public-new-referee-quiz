part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object> get props => [];
}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<Question> questions;

  const QuestionsLoaded([this.questions = const []]);

  @override
  List<Object> get props => [questions];

  @override
  String toString() => 'QuestionsLoaded { questions: $questions }';
}

class QuestionsNotLoaded extends QuestionsState {}
