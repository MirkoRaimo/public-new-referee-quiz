part of 'new_question_wizard_bloc.dart';

class NewQuestionWizardState extends Equatable {
  final Question question;
  final DateTime lastUpdated;

  NewQuestionWizardState({this.question}) : lastUpdated = DateTime.now();

  NewQuestionWizardState.initial() : this(question: Question());

  NewQuestionWizardState copyWith({Question question}) {
    return NewQuestionWizardState(question: question ?? this.question);
  }

  @override
  List<Object> get props => [question, lastUpdated];

  @override
  bool get stringify => true;
}

class NewQuestionWizardInitial extends NewQuestionWizardState {}
