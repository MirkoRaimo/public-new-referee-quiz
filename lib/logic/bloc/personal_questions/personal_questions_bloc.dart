import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuovoquizarbitri/logic/bloc/questions_bloc/questions_bloc.dart';
import 'package:nuovoquizarbitri/models/personal_questions.dart';
import 'package:questions_repository/questions_repository.dart';

part 'personal_questions_event.dart';
part 'personal_questions_state.dart';

class PersonalQuestionsBloc
    extends Bloc<PersonalQuestionsEvent, PersonalQuestionsState> {
  final QuestionsBloc questionsBloc;

  StreamSubscription questionsSubscription;

  PersonalQuestionsBloc({this.questionsBloc})
      : super(questionsBloc.state is QuestionsLoaded
            ? PersonalQuestionsLoaded(
                (questionsBloc as QuestionsLoaded).questions)
            : PersonalQuestionsLoading()) {
    questionsSubscription = questionsBloc.listen((state) {
      // if (state is PersonalQuestionsLoading) {
      //   questionsBloc.add(LoadQuestions());
      // } else
      if (state is QuestionsLoaded) {
        add(UpdateQuestions(
            (questionsBloc.state as QuestionsLoaded).questions));
      }
    });
  }

  @override
  Stream<PersonalQuestionsState> mapEventToState(
      PersonalQuestionsEvent event) async* {
    if (event is PLoadQuestions) {
      questionsBloc.add(LoadQuestions());
    } else if (event is UpdateQuestions) {
      yield* _mapUpdateQuestionsToState(event);
    } else if (event is AnswerQuestion) {
      //TODO: Handle normal answer question
      if (event.index == state.personalQuestions.questions.length - 1) {
        yield PQuestionsAllAnswered(state.personalQuestions);
      }
    }
  }

  Stream<PersonalQuestionsState> _mapUpdateQuestionsToState(
    UpdateQuestions event,
  ) async* {
    final currentState = questionsBloc.state;
    if (currentState is QuestionsLoaded) {
      yield PersonalQuestionsLoaded(currentState.questions);
    }
  }

  @override
  Future<void> close() {
    questionsSubscription?.cancel();
    return super.close();
  }
}
