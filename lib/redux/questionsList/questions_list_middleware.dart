import 'package:nuovoquizarbitri/redux/app/app_state.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_actions.dart';
import 'package:redux/redux.dart';

Middleware<AppState> createQuestionMiddleware() {
  return (Store <AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AnswerQuestion){

    }
    if (action is GenerateTrueFalseQuestions){

    }

    next(action);
  };
}