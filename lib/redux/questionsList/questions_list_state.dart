import 'package:flutter/widgets.dart';
import 'package:nuovoquizarbitri/redux/models/question.dart';

@immutable
class QuestionsListState {
  final BuildContext context;
  final List<Question> questionsList;
  final bool isAnswering;
  final bool answeredLastQuestion;
  final List<int> indexesCorrectQuestions;

  QuestionsListState(
      {this.context,
      this.questionsList,
      this.isAnswering,
      this.answeredLastQuestion = false,
      this.indexesCorrectQuestions = const []});

  QuestionsListState copyWith(
      {BuildContext context,
      List<Question> questionsList,
      bool isAnswering,
      bool answeredLastQuestion,
      List<int> indexesCorrectQuestions}) {
    return new QuestionsListState(
        context: context ?? this.context,
        questionsList: questionsList ?? this.questionsList,
        isAnswering: isAnswering ?? this.isAnswering,
        answeredLastQuestion: answeredLastQuestion ?? this.answeredLastQuestion,
        indexesCorrectQuestions:
            indexesCorrectQuestions ?? this.indexesCorrectQuestions);
  }

  factory QuestionsListState.initial() {
    return QuestionsListState(questionsList: [], isAnswering: false);
  }
}
