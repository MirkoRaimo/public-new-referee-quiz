import 'package:nuovoquizarbitri/redux/app/app_state.dart';
import 'package:redux/redux.dart';

Middleware<AppState> createSettingsMiddleware() {
  return (Store <AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
  };
}