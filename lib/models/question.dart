import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

//TODO: REMOVE THIS CLASS!!!!!!!!!!!!!!!!!!

@immutable
class Question extends Equatable {
  final String questionStatement;
  final List<String> possibleAnswers;
  final int correctAnswer; //position in the list having the possible answers
  final String strCorrectAnswer; //Correct answer provided as string
  final int givenAnswer;
  final int ruleRef; //reference to the rule id

  static const int TRUE = 0;
  static const int FALSE = 1;

  Question({
    this.questionStatement,
    this.possibleAnswers,
    correctAnswer,
    this.strCorrectAnswer,
    this.givenAnswer,
    this.ruleRef,
  }) : correctAnswer =
            calcTrueFalseCorrectAnswer(strCorrectAnswer, correctAnswer);

  static int calcTrueFalseCorrectAnswer(
      String strCorrectAnswer, int correctAnswer) {
    if (strCorrectAnswer.toLowerCase() == true.toString()) {
      return TRUE;
    } else if (strCorrectAnswer.toLowerCase() == false.toString()) {
      return FALSE;
    } else {
      return correctAnswer;
    }
  }

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

  Question copyWith({
    String questionStatement,
    List<String> possibleAnswers,
    int correctAnswer,
    String strCorrectAnswer,
    int givenAnswer,
    int ruleRef,
  }) {
    return Question(
      questionStatement: questionStatement ?? this.questionStatement,
      possibleAnswers: possibleAnswers ?? this.possibleAnswers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      strCorrectAnswer: strCorrectAnswer ?? this.strCorrectAnswer,
      givenAnswer: givenAnswer ?? this.givenAnswer,
      ruleRef: ruleRef ?? this.ruleRef,
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
  List<Object> get props {
    return [
      questionStatement,
      possibleAnswers,
      correctAnswer,
      strCorrectAnswer,
      givenAnswer,
      ruleRef,
    ];
  }

  @override
  bool get stringify => true;

  // Question copyWith({
  //   String? questionStatement,
  //   List<String>? possibleAnswers,
  //   int? correctAnswer,
  //   int? givenAnswer,
  //   int? ruleRef,
  // }) {
  //   return Question(
  //     questionStatement ?? this.questionStatement,
  //     possibleAnswers ?? this.possibleAnswers,
  //     correctAnswer ?? this.correctAnswer,
  //     givenAnswer ?? this.givenAnswer,
  //     ruleRef ?? this.ruleRef,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'questionStatement': questionStatement,
      'possibleAnswers': possibleAnswers,
      'correctAnswer': correctAnswer,
      'strCorrectAnswer': strCorrectAnswer,
      'givenAnswer': givenAnswer,
      'ruleRef': ruleRef,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionStatement: map['questionStatement'],
      possibleAnswers: List<String>.from(map['possibleAnswers']),
      correctAnswer: calcTrueFalseCorrectAnswer(
          map['strCorrectAnswer'], map['correctAnswer']),
      strCorrectAnswer: map['strCorrectAnswer'],
      givenAnswer: map['givenAnswer'],
      ruleRef: map['ruleRef'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
