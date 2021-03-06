part of 'personal_questions_bloc.dart';

abstract class PersonalQuestionsState extends QuestionsState {
  final PersonalQuestions personalQuestions;

  PersonalQuestionsState({this.personalQuestions});

  @override
  List<Object> get props => [personalQuestions];
}

class PersonalQuestionsLoading extends PersonalQuestionsState {}

class PersonalQuestionsLoaded extends PersonalQuestionsState {
  PersonalQuestionsLoaded(List<Question> questions)
      : super(personalQuestions: PersonalQuestions(questions: questions));

  PersonalQuestionsLoaded.answerQuestion(PersonalQuestions personalQuestions)
      : super(personalQuestions: personalQuestions);
}

class PQuestionsAllAnswered extends PersonalQuestionsState {
  PQuestionsAllAnswered(PersonalQuestions personalQuestions)
      : super(personalQuestions: personalQuestions);
}

class PQuestionsAnswered extends PersonalQuestionsState {
  PQuestionsAnswered(PersonalQuestions personalQuestions)
      : super(personalQuestions: personalQuestions);
}
