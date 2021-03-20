part of 'new_question_wizard_bloc.dart';

abstract class NewQuestionWizardEvent extends Equatable {
  const NewQuestionWizardEvent();

  @override
  List<Object> get props => [];
}

class NewQuestionWizardQeASubmitted extends NewQuestionWizardEvent {
  final Question question;
  NewQuestionWizardQeASubmitted({
    this.question,
  });

  @override
  List<Object> get props => [question];

  @override
  String toString() => 'NewQuestionWizardQeASubmitted(question: $question)';
}

class NewQuestionWizardCorrectIndexSubmitted extends NewQuestionWizardEvent {
  final int correctIndex;

  NewQuestionWizardCorrectIndexSubmitted({this.correctIndex});

  @override
  List<Object> get props => [correctIndex];

  @override
  String toString() =>
      'NewQuestionWizardCorrectIndexSubmitted(correctIndex: $correctIndex)';
}

class NewQuestionWizardOriginSubmitted extends NewQuestionWizardEvent {
  final String origin;

  NewQuestionWizardOriginSubmitted({this.origin});

  @override
  List<Object> get props => [origin];

  @override
  String toString() => 'NewQuestionWizardOriginSubmitted(origin: $origin)';
}
