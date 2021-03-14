import 'package:flutter/cupertino.dart';
import 'package:nuovoquizarbitri/redux/auth/auth_middleware.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_middleware.dart';
import 'package:nuovoquizarbitri/redux/settings/settings_middleware.dart';
import 'package:redux/redux.dart';
import 'app/app_state.dart';
import 'app/app_reducer.dart';

Store<AppState> createStore() {
  return Store(
      appReducer,
      initialState: AppState.initial(),
      middleware: []
        ..add(createQuestionMiddleware())
        ..add(createSettingsMiddleware())
        //..add(createAuthMiddleware(context))
  );
}