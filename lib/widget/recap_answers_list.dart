import 'package:flutter/material.dart';
import 'package:nuovoquizarbitri/models/personal_questions.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';
import 'package:questions_repository/questions_repository.dart';

Widget recapAnswersList(BuildContext context, List<Question> questions,
    List<int> indexesCorrectQuestions) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount:
          (questions != null && questions.isNotEmpty) ? questions.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(questions[index].questionStatement),
          trailing: indexesCorrectQuestions.contains(index)
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

Widget recapAnswers(BuildContext context, PersonalQuestions personalQuestions,
    {String msgToShow}) {
  print("recapAnswers method");
  msgToShow = msgToShow ?? STR_CORRECT_ANSWERS;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
          "$msgToShow ${personalQuestions.indexesCorrectQuestions.length} / ${personalQuestions.questions.length}"),
      Flexible(
          flex: 1,
          child: recapAnswersList(context, personalQuestions.questions,
              personalQuestions.indexesCorrectQuestions))
    ],
  );
}
