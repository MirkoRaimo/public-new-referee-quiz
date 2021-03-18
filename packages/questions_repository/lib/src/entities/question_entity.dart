import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuestionEntity extends Equatable {
  final String questionStatement;
  final String id;
  final List<String> possibleAnswers;
  final int correctAnswer; //position in the list having the possible answers
  final int givenAnswer;

  QuestionEntity({
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

  QuestionEntity copyWith({
    String questionStatement,
    String id,
    List<String> possibleAnswers,
    int correctAnswer,
    int givenAnswer,
  }) {
    return QuestionEntity(
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

  factory QuestionEntity.fromMap(Map<String, dynamic> map) {
    return QuestionEntity(
      questionStatement: map['questionStatement'],
      id: map['id'],
      possibleAnswers: List<String>.from(map['possibleAnswers']),
      correctAnswer: map['correctAnswer'],
      givenAnswer: map['givenAnswer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionEntity.fromJson(String source) =>
      QuestionEntity.fromMap(json.decode(source));

  static QuestionEntity fromSnapshot(DocumentSnapshot snap) {
    return QuestionEntity(
      questionStatement: snap.data()['questionStatement'],
      id: snap.id,
      possibleAnswers: snap.data()['possibleAnswers'],
      correctAnswer: snap.data()['correctAnswer'],
      givenAnswer: snap.data()['givenAnswer'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'questionStatement': questionStatement,
      'possibleAnswers': possibleAnswers,
      'correctAnswer': correctAnswer,
      'givenAnswer': givenAnswer,
    };
  }

  @override
  bool get stringify => true;
}
