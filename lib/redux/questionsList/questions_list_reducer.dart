import 'package:flutter/material.dart';
import 'package:nuovoquizarbitri/redux/models/question.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_actions.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_state.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';
import 'package:redux/redux.dart';

final questionsListReducer = combineReducers<QuestionsListState>([
  TypedReducer<QuestionsListState, AnswerQuestion>(_answeringQuestion),
  TypedReducer<QuestionsListState, SetQuestionsListContext>(_settingContext),
  TypedReducer<QuestionsListState, GenerateTrueFalseQuestions>(_generateTrueFalseQuestions),
  TypedReducer<QuestionsListState, GenerateQuizQuestions>(_generateQuizQuestions),
]);

QuestionsListState _answeringQuestion(QuestionsListState state, AnswerQuestion action) {
  if (state.questionsList != null && state.questionsList.isNotEmpty && action.currentQuestion != null){
    QuestionsListState tmpState = state;

    Question currentQuestion = state.questionsList[action.currentQuestion];

    currentQuestion.answeredCorrectly = currentQuestion.correctAnswer == action.givenAnswer;
    String textToShow = currentQuestion.answeredCorrectly ? "$STR_RIGHT!" : "$STR_WRONG!";
    print("Answed correctly: " + currentQuestion.answeredCorrectly.toString());
    Scaffold.of(state.context).showSnackBar(
        SnackBar(
          backgroundColor: currentQuestion.answeredCorrectly == true ? Colors.green : Colors.red,
          content:new Text(textToShow, textAlign: TextAlign.center,),
          duration: Duration(milliseconds: 400),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
//            action: new SnackBarAction(
//              textColor: Colors.black,
//              label: "OK",
//              onPressed: () => store.dispatch(DismissMessage()),
//            ),
        )
    );

    if (action.currentQuestion == state.questionsList.length -1){
       tmpState = tmpState.copyWith(
          answeredLastQuestion: true,
      );
    }

    if (currentQuestion.answeredCorrectly == true){
      tmpState = tmpState.copyWith(
        indexesCorrectQuestions: []..addAll(tmpState.indexesCorrectQuestions)..add(action.currentQuestion)
      );
    }

    return tmpState;
  }
  return state;
}

QuestionsListState _settingContext(QuestionsListState state, SetQuestionsListContext action) {
  return state.copyWith(
      context: action.context
  );
}

QuestionsListState _generateTrueFalseQuestions(QuestionsListState state, GenerateTrueFalseQuestions action) {
  const String _theAnswerIs = "The answer is:";

  List <Question> listOfQuestions = []
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_TRUE", correctAnswer: Question.TRUE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_FALSE", correctAnswer: Question.FALSE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_TRUE", correctAnswer: Question.TRUE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_FALSE", correctAnswer: Question.FALSE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_TRUE", correctAnswer: Question.TRUE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_FALSE", correctAnswer: Question.FALSE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_TRUE", correctAnswer: Question.TRUE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_FALSE", correctAnswer: Question.FALSE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_TRUE", correctAnswer: Question.TRUE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_FALSE", correctAnswer: Question.FALSE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_TRUE", correctAnswer: Question.TRUE))
    ..add(Question.trueFalse(questionStatement: "$_theAnswerIs $STR_FALSE", correctAnswer: Question.FALSE));

  return state.copyWith(
      questionsList: listOfQuestions
  );
}

QuestionsListState _generateQuizQuestions(QuestionsListState state, GenerateQuizQuestions action) {
  const String _theAnswerIs = "The answer is:";

  List <Question> listOfQuestions = []
    ..add(Question(questionStatement: "$_theAnswerIs $STR_TRUE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.TRUE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_FALSE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.FALSE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_TRUE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.TRUE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_FALSE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.FALSE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_TRUE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.TRUE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_FALSE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.FALSE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_TRUE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.TRUE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_FALSE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.FALSE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_TRUE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.TRUE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_FALSE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.FALSE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_TRUE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.TRUE))
    ..add(Question(questionStatement: "$_theAnswerIs $STR_FALSE", possibleAnswers: [STR_TRUE, STR_FALSE, STR_IMPOSSIBLE], correctAnswer: Question.FALSE));

  return state.copyWith(
      questionsList: listOfQuestions
  );
}