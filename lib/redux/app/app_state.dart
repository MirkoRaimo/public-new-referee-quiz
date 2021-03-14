import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_state.dart';

@immutable
class AppState {
  final QuestionsListState questionsListState;
  final User currentUser;

  AppState({
    this.questionsListState,
    this.currentUser,
  });

  factory AppState.initial() {
    return AppState(
        questionsListState: QuestionsListState.initial(), currentUser: null);
  }

  AppState copyWith({
    QuestionsListState questionsListState,
    User currentUser,
  }) {
    return AppState(
      questionsListState: questionsListState ?? this.questionsListState,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  int get hashCode => currentUser.hashCode;

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          currentUser == other.currentUser;
}
