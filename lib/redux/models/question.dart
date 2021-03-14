import 'package:flutter/widgets.dart';

@immutable
class Question{
  final BuildContext context;
  final String questionStatement;
  final List<String> possibleAnswers;
  final int correctAnswer; //position of the list of the possible answers
  final int givenAnswer;
  bool answeredCorrectly;

  static const int TRUE = 0;
  static const int FALSE = 1;

  Question({this.context, this.questionStatement, this.possibleAnswers,
      this.correctAnswer, this.givenAnswer, this.answeredCorrectly}){
    if (givenAnswer != null){
      if (correctAnswer != null){
        if (givenAnswer == correctAnswer){
          answeredCorrectly = true;
        }
      }else{
        print("Correct answer not provided for the question $questionStatement");
      }
    }
  }

  Question copyWith({BuildContext context, String questionStatement, List<String> possibleAnswers, int correctAnswer, int givenAnswer, bool answeredCorrectly}){
    return new Question(
        context: context ?? this.context,
        questionStatement: questionStatement ?? this.questionStatement,
        possibleAnswers: possibleAnswers ?? this.possibleAnswers,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        givenAnswer: givenAnswer ?? this.givenAnswer,
        answeredCorrectly: answeredCorrectly ?? this.answeredCorrectly
    );
  }

  factory Question.initial(){
    return new Question(questionStatement: "Default question, correct answer: true", answeredCorrectly: false, correctAnswer: Question.TRUE);
  }

  factory Question.trueFalse({@required String questionStatement, @required int correctAnswer}){
    Question questionState = new Question.initial();
    questionState = questionState.copyWith(questionStatement: questionStatement, correctAnswer: correctAnswer);
    return questionState;
  }
}