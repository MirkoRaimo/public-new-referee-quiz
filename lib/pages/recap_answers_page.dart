import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nuovoquizarbitri/redux/app/app_state.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_state.dart';
import 'package:nuovoquizarbitri/widget/recap_answers_list.dart';

class RecapAnswersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuestionsListState>(
        converter: (store) => store.state.questionsListState,
        builder: (BuildContext context, QuestionsListState questionsListState) {
          return Flexible(flex: 2,child: recapAnswers(context, questionsListState));
        });
  }
}
