import 'package:nuovoquizarbitri/redux/auth/auth_reducer.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_reducer.dart';
import 'package:nuovoquizarbitri/redux/settings/settings_reducer.dart';
import './app_state.dart';

import 'app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    questionsListState: questionsListReducer(state.questionsListState,action),
    settingsState: settingsReducer(state.settingsState, action),
    currentUser: authReducer(state.currentUser, action),
  );
}