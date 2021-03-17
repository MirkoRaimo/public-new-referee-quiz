import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuovoquizarbitri/redux/auth/auth_actions.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<User>([
  new TypedReducer<User, LogInSuccessful>(_logIn) as User Function(
      User, dynamic),
  new TypedReducer<User, LogOutSuccessful>(_logOut) as User Function(
      User, dynamic),
]);

User _logIn(User user, action) {
  return action.user;
}

Null _logOut(User user, action) {
  return null;
}
