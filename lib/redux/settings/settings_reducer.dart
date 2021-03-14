import 'package:nuovoquizarbitri/redux/settings/settings_actions.dart';
import 'package:nuovoquizarbitri/redux/settings/settings_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsReducer = combineReducers<SettingsState>([
  TypedReducer<SettingsState, SetDarkMode>(_settingDarkMode),
]);

SettingsState _settingDarkMode(SettingsState state, SetDarkMode action) {
  setSPDarkMode(action.darkMode);

  return state.copyWith(
    darkMode: action.darkMode
  );
}

Future<bool> setSPDarkMode(bool darkMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool("darkMode", darkMode);
}