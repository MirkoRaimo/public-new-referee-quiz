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
      yield _answeringQuestion(event, state);
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

  PersonalQuestionsState _answeringQuestion(
      AnswerQuestion event, PersonalQuestionsState state) {
    Question currentQuestion = state.personalQuestions.questions[event.index];
    bool answeredCorrectly = currentQuestion.correctAnswer == event.givenAnswer;

//TODO: MOVE THIS LOGIC TO THE UI
//     print("Answed correctly: " + answeredCorrectly.toString());
//     Scaffold.of(state.context).showSnackBar(SnackBar(
//       backgroundColor:
//           currentQuestion.answeredCorrectly == true ? Colors.green : Colors.red,
//       content: new Text(
//         textToShow,
//         textAlign: TextAlign.center,
//       ),
//       duration: Duration(milliseconds: 400),
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20))),
// //            action: new SnackBarAction(
// //              textColor: Colors.black,
// //              label: "OK",
// //              onPressed: () => store.dispatch(DismissMessage()),
// //            ),
//     ));

    if (answeredCorrectly) {
      PersonalQuestions newPersonalQuestions = state.personalQuestions.copyWith(
          indexesCorrectQuestions: []
            ..addAll(state.personalQuestions.indexesCorrectQuestions)
            ..add(event.index));
      return new PersonalQuestionsLoaded.answerQuestion(newPersonalQuestions);
    }
    return state;
  }

//   QuestionsListState _answeringQuestion_old(
//       QuestionsListState state, AnswerQuestion action) {
//     if (state.questionsList != null &&
//         state.questionsList.isNotEmpty &&
//         action.currentQuestion != null) {
//       QuestionsListState tmpState = state;

//       Question currentQuestion = state.questionsList[action.currentQuestion];

//       currentQuestion.answeredCorrectly =
//           currentQuestion.correctAnswer == action.givenAnswer;
//       String textToShow =
//           currentQuestion.answeredCorrectly ? "$STR_RIGHT!" : "$STR_WRONG!";
//       print(
//           "Answed correctly: " + currentQuestion.answeredCorrectly.toString());
//       Scaffold.of(state.context).showSnackBar(SnackBar(
//         backgroundColor: currentQuestion.answeredCorrectly == true
//             ? Colors.green
//             : Colors.red,
//         content: new Text(
//           textToShow,
//           textAlign: TextAlign.center,
//         ),
//         duration: Duration(milliseconds: 400),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20))),
// //            action: new SnackBarAction(
// //              textColor: Colors.black,
// //              label: "OK",
// //              onPressed: () => store.dispatch(DismissMessage()),
// //            ),
//       ));

//       if (action.currentQuestion == state.questionsList.length - 1) {
//         tmpState = tmpState.copyWith(
//           answeredLastQuestion: true,
//         );
//       }

//       if (currentQuestion.answeredCorrectly == true) {
//         tmpState = tmpState.copyWith(
//             indexesCorrectQuestions: []
//               ..addAll(tmpState.indexesCorrectQuestions)
//               ..add(action.currentQuestion));
//       }

//       return tmpState;
//     }
//     return state;
//   }

  @override
  Future<void> close() {
    questionsSubscription?.cancel();
    return super.close();
  }
}
