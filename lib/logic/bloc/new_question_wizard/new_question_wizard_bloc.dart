import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:questions_repository/questions_repository.dart';

part 'new_question_wizard_event.dart';
part 'new_question_wizard_state.dart';

class NewQuestionWizardBloc
    extends Bloc<NewQuestionWizardEvent, NewQuestionWizardState> {
  NewQuestionWizardBloc() : super(NewQuestionWizardInitial());

  @override
  Stream<NewQuestionWizardState> mapEventToState(
    NewQuestionWizardEvent event,
  ) async* {
    if (event is NewQuestionWizardQeASubmitted) {
      if (event.question.trueFalseQuestion == true) {
        yield state.copyWith(
            question: Question.trueFalseQuestion(event.question));
      } else {
        yield state.copyWith(question: event.question);
      }
    } else if (event is NewQuestionWizardCorrectIndexSubmitted) {
      yield state.copyWith(
          question: state.question.copyWith(correctAnswer: event.correctIndex));
    } else if (event is NewQuestionWizardOriginSubmitted) {
      state.question.possibleAnswers.removeWhere((element) => element.isEmpty);
      yield state.copyWith(
          question: state.question.copyWith(origin: event.origin));
    }
  }
}
