import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:questions_repository/questions_repository.dart';
part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionsRepository _questionsRepository;
  StreamSubscription _questionsSubscription;

  QuestionsBloc({QuestionsRepository questionsRepository})
      : assert(questionsRepository != null),
        _questionsRepository = questionsRepository,
        super(QuestionsLoading());

  @override
  Stream<QuestionsState> mapEventToState(QuestionsEvent event) async* {
    if (event is LoadTrueFalseQuestions) {
      yield* _mapLoadTrueFalseQuestionsToState();
    } else if (event is LoadQuestions) {
      yield* _mapLoadQuestionsToState();
    } else if (event is AddQuestion) {
      yield* _mapAddQuestionToState(event);
    } else if (event is UpdateQuestion) {
      yield* _mapUpdateQuestionToState(event);
    } else if (event is DeleteQuestion) {
      yield* _mapDeleteQuestionToState(event);
    } else if (event is QuestionsUpdated) {
      yield* _mapQuestionsUpdateToState(event);
    }
  }

  Stream<QuestionsState> _mapLoadTrueFalseQuestionsToState() async* {
    _questionsSubscription?.cancel();
    _questionsSubscription =
        _questionsRepository.questions().listen((questions) {
      questions = questions
          .where((question) => Question.isTrueFalseQuestion(question))
          .toList()
            ..shuffle();
      add(QuestionsUpdated((questions.sublist(
          0, questions.length < 10 ? questions.length : 10))));
    });
  }

  // bool isTrueFalseQuestion(Question question) {
  //   String lowerFirstAnswer = question.possibleAnswers[0].toLowerCase();
  //   return lowerFirstAnswer.contains(true.toString()) ||
  //       lowerFirstAnswer.contains(true.toString());
  // }

  Stream<QuestionsState> _mapLoadQuestionsToState() async* {
    _questionsSubscription?.cancel();
    _questionsSubscription = _questionsRepository.questions().listen(
          (questions) => add(QuestionsUpdated(questions)),
        );
  }

  Stream<QuestionsState> _mapAddQuestionToState(AddQuestion event) async* {
    _questionsRepository.addNewQuestion(event.question);
  }

  Stream<QuestionsState> _mapUpdateQuestionToState(
      UpdateQuestion event) async* {
    _questionsRepository.updateQuestion(event.updatedQuestion);
  }

  Stream<QuestionsState> _mapDeleteQuestionToState(
      DeleteQuestion event) async* {
    _questionsRepository.deleteQuestion(event.question);
  }

  Stream<QuestionsState> _mapQuestionsUpdateToState(
      QuestionsUpdated event) async* {
    yield QuestionsLoaded(event.questions);
  }

  @override
  Future<void> close() {
    _questionsSubscription?.cancel();
    return super.close();
  }
}
