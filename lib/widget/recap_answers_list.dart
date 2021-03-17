import 'package:flutter/material.dart';
import 'package:nuovoquizarbitri/redux/models/question.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_state.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';

Widget recapAnswersList(BuildContext context, List<Question> questions) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount:
          (questions != null && questions.isNotEmpty) ? questions.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(questions[index].questionStatement),
          trailing: questions[index].answeredCorrectly
              ? Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
        );
      });
}

Widget recapAnswers(BuildContext context, QuestionsListState questionsListState,
    {String msgToShow}) {
  print("recapAnswers method");
  msgToShow = msgToShow ?? STR_CORRECT_ANSWERS;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
          "$msgToShow ${questionsListState.indexesCorrectQuestions.length} / ${questionsListState.questionsList.length}"),
      Flexible(
          flex: 1,
          child: recapAnswersList(context, questionsListState.questionsList))
    ],
  );
}
