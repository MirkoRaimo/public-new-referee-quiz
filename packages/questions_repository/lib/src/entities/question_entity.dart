import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:questions_repository/src/models/questionUser.dart';

class QuestionEntity extends Equatable {
  final String questionStatement;
  final String id;
  final List<String> possibleAnswers;
  final int correctAnswer; //position in the list having the possible answers
  final int givenAnswer;
  final String origin;
  final bool trueFalseQuestion;
  final QuestionUser utIns;
  final QuestionUser utVar;
  final Timestamp dtIns;
  final Timestamp dtVar;

  QuestionEntity({
    this.questionStatement,
    this.id,
    this.possibleAnswers,
    this.correctAnswer,
    this.givenAnswer,
    this.origin,
    this.trueFalseQuestion,
    this.utIns,
    this.utVar,
    this.dtIns,
    this.dtVar,
  });

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
      utIns,
      utVar,
      dtIns,
      dtVar,
    ];
  }

  QuestionEntity copyWith({
    String questionStatement,
    String id,
    List<String> possibleAnswers,
    int correctAnswer,
    int givenAnswer,
    String origin,
    bool trueFalseQuestion,
    QuestionUser utIns,
    QuestionUser utVar,
    Timestamp dtIns,
    Timestamp dtVar,
  }) {
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
      dtVar: dtVar ?? this.dtVar,
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
      'utIns': utIns,
      'utVar': utVar,
      'dtIns': dtIns,
      'dtVar': dtVar,
    };
  }

  factory QuestionEntity.fromMap(Map<String, dynamic> map) {
    return QuestionEntity(
      questionStatement: map['questionStatement'],
      id: map['id'],
      possibleAnswers: List<String>.from(map['possibleAnswers']),
      correctAnswer: map['correctAnswer'],
      givenAnswer: map['givenAnswer'],
      origin: map['origin'],
      trueFalseQuestion: map['trueFalseQuestion'],
      utIns: map['utIns'],
      utVar: map['utVar'],
      dtIns: map['dtIns'],
      dtVar: map['dtVar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionEntity.fromJson(String source) =>
      QuestionEntity.fromMap(json.decode(source));

  static QuestionEntity fromSnapshot(DocumentSnapshot snap) {
    return QuestionEntity(
      questionStatement: snap.data()['questionStatement'],
      id: snap.id,
      //possibleAnswers: new List<String>.from(snap.data()['possibleAnswers']),
      possibleAnswers: (snap.data()['possibleAnswers']).cast<String>(),
      correctAnswer: snap.data()['correctAnswer'],
      givenAnswer: snap.data()['givenAnswer'],
      origin: snap.data()['origin'],
      trueFalseQuestion: snap.data()['trueFalseQuestion'],
      utIns: snap.data()['utIns'],
      utVar: snap.data()['utVar'],
      dtIns: snap.data()['dtIns'],
      dtVar: snap.data()['dtVar'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'questionStatement': questionStatement,
      'possibleAnswers': possibleAnswers,
      'correctAnswer': correctAnswer,
      'givenAnswer': givenAnswer,
      'origin': origin,
      'trueFalseQuestion': trueFalseQuestion,
      'utIns': utIns,
      'utVar': utVar,
      'dtIns': dtIns,
      'dtVar': dtVar,
    };
  }

  @override
  bool get stringify => true;
}
