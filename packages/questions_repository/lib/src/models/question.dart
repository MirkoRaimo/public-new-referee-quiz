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
  Question({
    this.questionStatement,
    this.id,
    this.possibleAnswers,
    this.correctAnswer,
    this.givenAnswer,
  });

  @override
  List<Object> get props {
    return [
      questionStatement,
      id,
      possibleAnswers,
      correctAnswer,
      givenAnswer,
    ];
  }

  Question copyWith({
    String questionStatement,
    String id,
    List<String> possibleAnswers,
    int correctAnswer,
    int givenAnswer,
  }) {
    return Question(
      questionStatement: questionStatement ?? this.questionStatement,
      id: id ?? this.id,
      possibleAnswers: possibleAnswers ?? this.possibleAnswers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      givenAnswer: givenAnswer ?? this.givenAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionStatement': questionStatement,
      'id': id,
      'possibleAnswers': possibleAnswers,
      'correctAnswer': correctAnswer,
      'givenAnswer': givenAnswer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionStatement: map['questionStatement'],
      id: map['id'],
      possibleAnswers: List<String>.from(map['possibleAnswers']),
      correctAnswer: map['correctAnswer'],
      givenAnswer: map['givenAnswer'],
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
    );
  }

  static Question fromEntity(QuestionEntity entity) {
    return Question(
      questionStatement: entity.questionStatement,
      id: entity.id,
      possibleAnswers: entity.possibleAnswers,
      correctAnswer: entity.correctAnswer,
      givenAnswer: entity.givenAnswer,
    );
  }

  @override
  bool get stringify => true;
}
