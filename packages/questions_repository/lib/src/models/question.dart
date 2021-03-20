import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../entities/question_entity.dart';

@immutable
class Question extends Equatable {
  final String questionStatement;
  final String id;
  final List<String> possibleAnswers;
  final int correctAnswer; //position in the list having the possible answers
  final int givenAnswer;
  final String origin; //where the question was found
  final bool trueFalseQuestion; //represents if the question is true or false
  //TODO: insert insertDate and userInsert as fields

  static const String ANSW_STR_TRUE = 'Vero';
  static const String ANSW_STR_FALSE = 'Falso';
  static const int ANSW_IDX_TRUE = 0;
  static const int ANSW_IDX_FALSE = 1;

  Question(
      {this.questionStatement,
      this.id,
      this.possibleAnswers,
      this.correctAnswer,
      this.givenAnswer,
      this.origin,
      this.trueFalseQuestion});

  @override
  List<Object> get props {
    return [
      questionStatement,
      id,
      possibleAnswers,
      correctAnswer,
      givenAnswer,
      origin,
      trueFalseQuestion,
    ];
  }

  Question copyWith({
    String questionStatement,
    String id,
    List<String> possibleAnswers,
    int correctAnswer,
    int givenAnswer,
    String origin,
    bool trueFalseQuestion,
  }) {
    return Question(
      questionStatement: questionStatement ?? this.questionStatement,
      id: id ?? this.id,
      possibleAnswers: possibleAnswers ?? this.possibleAnswers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      givenAnswer: givenAnswer ?? this.givenAnswer,
      origin: origin ?? this.origin,
      trueFalseQuestion: trueFalseQuestion ?? this.trueFalseQuestion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionStatement': questionStatement,
      'id': id,
      'possibleAnswers': possibleAnswers,
      'correctAnswer': correctAnswer,
      'givenAnswer': givenAnswer,
      'origin': origin,
      'trueFalseQuestion': trueFalseQuestion,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionStatement: map['questionStatement'],
      id: map['id'],
      possibleAnswers: List<String>.from(map['possibleAnswers']),
      correctAnswer: map['correctAnswer'],
      givenAnswer: map['givenAnswer'],
      origin: map['origin'],
      trueFalseQuestion: map['trueFalseQuestion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  QuestionEntity toEntity() {
    return QuestionEntity(
        questionStatement: questionStatement ?? this.questionStatement,
        id: id ?? this.id,
        possibleAnswers: possibleAnswers ?? this.possibleAnswers,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        givenAnswer: givenAnswer ?? this.givenAnswer,
        origin: origin ?? this.origin,
        trueFalseQuestion: trueFalseQuestion ?? this.trueFalseQuestion);
  }

  static Question fromEntity(QuestionEntity entity) {
    return Question(
        questionStatement: entity.questionStatement,
        id: entity.id,
        possibleAnswers: entity.possibleAnswers,
        correctAnswer: entity.correctAnswer,
        givenAnswer: entity.givenAnswer,
        origin: entity.origin,
        trueFalseQuestion: entity.trueFalseQuestion);
  }

  factory Question.trueFalseQuestion(Question question) {
    return Question(
      questionStatement: question.questionStatement,
      id: question.id,
      possibleAnswers: [ANSW_STR_TRUE, ANSW_STR_FALSE],
      correctAnswer: question.correctAnswer,
      givenAnswer: question.givenAnswer,
      origin: question.origin,
      trueFalseQuestion: question.trueFalseQuestion ?? true,
    );
  }

  @override
  bool get stringify => true;
}
