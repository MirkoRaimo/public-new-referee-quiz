import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class Question extends Equatable {
  final String questionStatement;
  final List<String> possibleAnswers;
  final int correctAnswer; //position in the list having the possible answers
  final int givenAnswer;

  static const int TRUE = 0;
  static const int FALSE = 1;

  Question(
      {this.questionStatement,
      this.possibleAnswers,
      this.correctAnswer,
      this.givenAnswer});

  bool answeredCorrectly() {
    bool answeredCorrectly = false;
    if (givenAnswer != null) {
      if (correctAnswer != null) {
        if (givenAnswer == correctAnswer) {
          answeredCorrectly = true;
        }
      } else {
        print(
            "Correct answer not provided for the question $questionStatement");
      }
    }
    return answeredCorrectly;
  }

  Question copyWith(
      {String questionStatement,
      List<String> possibleAnswers,
      int correctAnswer,
      int givenAnswer,
      bool answeredCorrectly}) {
    return new Question(
      questionStatement: questionStatement ?? this.questionStatement,
      possibleAnswers: possibleAnswers ?? this.possibleAnswers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      givenAnswer: givenAnswer ?? this.givenAnswer,
    );
  }

  factory Question.initial() {
    return new Question(
        questionStatement: "Default question, correct answer: true",
        correctAnswer: Question.TRUE);
  }

  factory Question.trueFalse({String questionStatement, int correctAnswer}) {
    Question questionState = new Question.initial();
    questionState = questionState.copyWith(
        questionStatement: questionStatement, correctAnswer: correctAnswer);
    return questionState;
  }

  @override
  List<Object> get props =>
      [questionStatement, possibleAnswers, correctAnswer, givenAnswer];

  @override
  bool get stringify => true;
}
