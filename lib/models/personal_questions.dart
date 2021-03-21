import 'package:flutter/widgets.dart';
import 'package:questions_repository/questions_repository.dart';

//Model used to handle the personal session of each user
@immutable
class PersonalQuestions {
  final List<Question> questions;
  final bool isAnswering;
  final bool answeredLastQuestion;
  final List<int> indexesCorrectQuestions;

  PersonalQuestions(
      {this.questions,
      this.isAnswering,
      this.answeredLastQuestion = false,
      this.indexesCorrectQuestions = const []});

  PersonalQuestions copyWith(
      {List<Question> questions,
      bool isAnswering,
      bool answeredLastQuestion,
      List<int> indexesCorrectQuestions}) {
    return new PersonalQuestions(
        questions: questions ?? this.questions,
        isAnswering: isAnswering ?? this.isAnswering,
        answeredLastQuestion: answeredLastQuestion ?? this.answeredLastQuestion,
        indexesCorrectQuestions:
            indexesCorrectQuestions ?? this.indexesCorrectQuestions);
  }

  factory PersonalQuestions.initial() {
    return PersonalQuestions(questions: [], isAnswering: false);
  }
}
