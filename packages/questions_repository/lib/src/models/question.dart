import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../entities/question_entity.dart';

@immutable
class Question extends Equatable {
  final String questionStatement;
  final String id;
  final List<String> possibleAnswers;
  final int correctAnswer; //position in the list having the possible answers
  final String strCorrectAnswer; //Correct answer provided as string
  final int givenAnswer;
  final String origin; //where the question was found
  final bool trueFalseQuestion; //represents if the question is true or false
  final int ruleRef; //reference to the rule id
  final User utIns;
  final User utVar;
  final Timestamp dtIns;
  final Timestamp dtVar;

  static const String ANSW_STR_TRUE = 'Vero';
  static const String ANSW_STR_FALSE = 'Falso';
  static const int ANSW_IDX_TRUE = 0;
  static const int ANSW_IDX_FALSE = 1;

  Question({
    this.questionStatement,
    this.id,
    this.possibleAnswers,
    correctAnswer,
    this.strCorrectAnswer,
    this.givenAnswer,
    this.origin,
    this.trueFalseQuestion,
    this.ruleRef,
    this.utIns,
    this.utVar,
    this.dtIns,
    this.dtVar,
  }) : correctAnswer =
            calcTrueFalseCorrectAnswer(strCorrectAnswer, correctAnswer);

  static int calcTrueFalseCorrectAnswer(
      String strCorrectAnswer, int correctAnswer) {
    if (strCorrectAnswer != null && strCorrectAnswer.isNotEmpty) {
      switch (strCorrectAnswer.toLowerCase()) {
        case "true":
        case "vero":
          return ANSW_IDX_TRUE;
        case "false":
        case "falso":
          return ANSW_IDX_FALSE;
      }
    }
    return correctAnswer;
  }

  static bool isTrueFalseQuestion(Question question) {
    if (question.trueFalseQuestion != null) {
      return question.trueFalseQuestion;
    }
    switch (question.strCorrectAnswer.toLowerCase()) {
      case "true":
      case "vero":
      case "false":
      case "falso":
        return true;
    }
    return false;
  }

  @override
  List<Object> get props {
    return [
      questionStatement,
      id,
      possibleAnswers,
      correctAnswer,
      strCorrectAnswer,
      givenAnswer,
      origin,
      trueFalseQuestion,
      ruleRef,
      utIns,
      utVar,
      dtIns,
      dtVar,
    ];
  }

  Question copyWith({
    String questionStatement,
    String id,
    List<String> possibleAnswers,
    int correctAnswer,
    String strCorrectAnswer,
    int givenAnswer,
    String origin,
    bool trueFalseQuestion,
    int ruleRef,
    User utIns,
    User utVar,
    Timestamp dtIns,
    Timestamp dtVar,
  }) {
    return Question(
      questionStatement: questionStatement ?? this.questionStatement,
      id: id ?? this.id,
      possibleAnswers: possibleAnswers ?? this.possibleAnswers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      strCorrectAnswer: strCorrectAnswer ?? this.strCorrectAnswer,
      givenAnswer: givenAnswer ?? this.givenAnswer,
      origin: origin ?? this.origin,
      trueFalseQuestion: trueFalseQuestion ?? this.trueFalseQuestion,
      ruleRef: ruleRef ?? this.ruleRef,
      utIns: utIns ?? this.utIns,
      utVar: utVar ?? this.utVar,
      dtIns: dtIns ?? this.dtIns,
      dtVar: dtVar ?? this.dtVar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionStatement': questionStatement,
      'id': id,
      'possibleAnswers': possibleAnswers,
      'correctAnswer': correctAnswer,
      'strCorrectAnswer': strCorrectAnswer,
      'givenAnswer': givenAnswer,
      'origin': origin,
      'trueFalseQuestion': trueFalseQuestion,
      'ruleRef': ruleRef,
      // 'utIns': utIns.toMap(),
      // 'utVar': utVar.toMap(),
      // 'dtIns': dtIns.toMap(),
      // 'dtVar': dtVar.toMap(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionStatement: map['questionStatement'],
      id: map['id'],
      possibleAnswers: List<String>.from(map['possibleAnswers']),
      correctAnswer: calcTrueFalseCorrectAnswer(
          map['strCorrectAnswer'], map['correctAnswer']),
      strCorrectAnswer: map['strCorrectAnswer'],
      givenAnswer: map['givenAnswer'],
      origin: map['origin'],
      trueFalseQuestion: map['trueFalseQuestion'],
      ruleRef: map['ruleRef'],
      // utIns: User.fromMap(map['utIns']),
      // utVar: User.fromMap(map['utVar']),
      // dtIns: Timestamp.fromMap(map['dtIns']),
      // dtVar: Timestamp.fromMap(map['dtVar']),
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
        trueFalseQuestion: trueFalseQuestion ?? this.trueFalseQuestion,
        utIns: utIns ?? this.utIns,
        utVar: utVar ?? this.utVar,
        dtIns: dtIns ?? this.dtIns,
        dtVar: dtVar ?? this.dtVar);
  }

  static Question fromEntity(QuestionEntity entity) {
    return Question(
      questionStatement: entity.questionStatement,
      id: entity.id,
      possibleAnswers: entity.possibleAnswers,
      correctAnswer: entity.correctAnswer,
      givenAnswer: entity.givenAnswer,
      origin: entity.origin,
      trueFalseQuestion: entity.trueFalseQuestion,
      utIns: entity.utIns,
      utVar: entity.utVar,
      dtIns: entity.dtIns,
      dtVar: entity.dtVar,
    );
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
      utIns: question.utIns,
      utVar: question.utVar,
      dtIns: question.dtIns,
      dtVar: question.dtVar,
    );
  }

  @override
  bool get stringify => true;
}
