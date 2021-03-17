import 'package:flutter/widgets.dart';

class AnswerQuestion {
  int currentQuestion; //Position of the question inside the list
  int givenAnswer;

  AnswerQuestion({this.currentQuestion, this.givenAnswer});
}

class SetQuestionsListContext {
  final BuildContext context;

  SetQuestionsListContext({
    this.context,
  });
}

class GenerateTrueFalseQuestions {
  GenerateTrueFalseQuestions();
}

class GenerateQuizQuestions {
  GenerateQuizQuestions();
}
