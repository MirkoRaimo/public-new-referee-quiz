import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/auth_bloc/authentication_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/questions_bloc/questions_bloc.dart';
import 'package:questions_repository/questions_repository.dart';

import 'package:nuovoquizarbitri/logic/bloc/new_question_wizard/new_question_wizard_bloc.dart';

class NewQuestionWizard extends StatelessWidget {
  static Route<Question> route() {
    return MaterialPageRoute(builder: (_) => NewQuestionWizard());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewQuestionWizardBloc(),
        ),
        BlocProvider(
          create: (_) => QuestionsBloc(
            questionsRepository: FirebaseQuestionsRepository(),
          ),
        )
      ],
      child: NewQuestionWizardController(
        onComplete: (newQuestion) => Navigator.of(context).pop(newQuestion),
      ),
    );

    // return BlocProvider(
    //   create: (_) => NewQuestionWizardBloc(),
    //   child: NewQuestionWizardController(
    //     onComplete: (newQuestion) => Navigator.of(context).pop(newQuestion),
    //   ),
    // );
  }
}

class NewQuestionWizardController extends StatefulWidget {
  const NewQuestionWizardController({Key key, this.onComplete})
      : super(key: key);

  final ValueSetter<Question> onComplete;

  @override
  _NewQuestionWizardControllerState createState() =>
      _NewQuestionWizardControllerState();
}

class _NewQuestionWizardControllerState
    extends State<NewQuestionWizardController> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewQuestionWizardBloc, NewQuestionWizardState>(
      listener: (context, state) async {
        if (state.question.origin != null) {
          widget.onComplete(state.question);
        } else if (state.question.correctAnswer?.isNaN == false) {
          _navigator?.push(NewQuestionOriginForm.route(state.question));
        } else if (state.question.questionStatement?.isNotEmpty == true) {
          _navigator?.push(NewQuestionCorrectIndexForm.route(state.question));
        }
      },
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (_) => NewQuestionQeAForm.route(),
      ),
    );
  }
}

class NewQuestionQeAForm extends StatefulWidget {
  final bool isEditing;

  const NewQuestionQeAForm({
    Key key,
    this.isEditing = false,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => NewQuestionQeAForm());
  }

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _NewQuestionQeAFormState createState() => _NewQuestionQeAFormState();
}

class _NewQuestionQeAFormState extends State<NewQuestionQeAForm> {
  Question question =
      new Question(possibleAnswers: List.generate(4, (index) => null));

  bool _trueOrFalseQuestion = true;

  int value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proponi una nuova domanda')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: NewQuestionQeAForm._formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue:
                    widget.isEditing ? question.questionStatement : '',
                maxLines: 10,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: 'Proponi una nuova domanda...',
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? 'Questo campo non può essere vuoto'
                      : null;
                },
                onSaved: (value) =>
                    question = question.copyWith(questionStatement: value),
              ),
              SwitchListTile.adaptive(
                  title: Text('Vero o Falso?'),
                  value: _trueOrFalseQuestion,
                  onChanged: (value) => setState(() {
                        _trueOrFalseQuestion = value;
                      })),
              Visibility(
                  visible: !_trueOrFalseQuestion,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: question.possibleAnswers.length,
                      itemBuilder: (context, index) {
                        return TextFormField(
                          initialValue: widget.isEditing
                              ? question.possibleAnswers[index]
                              : '',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                          decoration: InputDecoration(
                            hintText: 'Possibile risposta ${index + 1}',
                          ),
                          validator: (val) {
                            return val.trim().isEmpty && index < 3
                                ? 'Questo campo non può essere vuoto'
                                : null;
                          },
                          onSaved: (value) =>
                              question.possibleAnswers[index] = value,
                        );
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Seleziona la risposta corretta',
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          if (NewQuestionQeAForm._formKey.currentState.validate()) {
            NewQuestionQeAForm._formKey.currentState.save();
            context.read<NewQuestionWizardBloc>().add(
                NewQuestionWizardQeASubmitted(
                    question: question.copyWith(
                        trueFalseQuestion: _trueOrFalseQuestion,
                        utIns: context.read<AuthenticationBloc>().state.user,
                        dtIns: Timestamp.now())));
          }
        },
      ),
    );
  }
}

class NewQuestionCorrectIndexForm extends StatefulWidget {
  final bool isEditing;
  final Question question;

  const NewQuestionCorrectIndexForm({
    Key key,
    this.isEditing,
    this.question,
  }) : super(key: key);

  static Route route(Question question) {
    return MaterialPageRoute(
        builder: (_) => NewQuestionCorrectIndexForm(
              question: question,
            ));
  }

  @override
  _NewQuestionCorrectIndexFormState createState() =>
      _NewQuestionCorrectIndexFormState();
}

class _NewQuestionCorrectIndexFormState
    extends State<NewQuestionCorrectIndexForm> {
  int _correctIndex;
  Question question;

  @override
  void initState() {
    _correctIndex = 0;
    question = widget.question;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleziona la risposta corretta')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: question.possibleAnswers.length,
          itemBuilder: (context, index) {
            if (question.possibleAnswers[index].isNotEmpty) {
              return RadioListTile(
                value: index,
                groupValue: _correctIndex,
                onChanged: (ind) => setState(() => _correctIndex = ind),
                title: Text(question.possibleAnswers[index]),
              );
            } else
              return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Qual\'è l\'origine?',
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          if (NewQuestionQeAForm._formKey.currentState.validate()) {
            NewQuestionQeAForm._formKey.currentState.save();
            context.read<NewQuestionWizardBloc>().add(
                NewQuestionWizardCorrectIndexSubmitted(
                    correctIndex: _correctIndex));
          }
        },
      ),
    );
  }
}

class NewQuestionOriginForm extends StatefulWidget {
  final bool isEditing;
  final Question question;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  const NewQuestionOriginForm({Key key, this.isEditing = false, this.question})
      : super(key: key);

  static Route route(Question question) {
    return MaterialPageRoute(
        builder: (_) => NewQuestionOriginForm(
              question: question,
            ));
  }

  @override
  _NewQuestionOriginFormState createState() => _NewQuestionOriginFormState();
}

class _NewQuestionOriginFormState extends State<NewQuestionOriginForm> {
  String _origin;
  Question question;

  @override
  void initState() {
    _origin = '';
    question = widget.question;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const SelectableText('Qual\'è l\'origine?')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: NewQuestionOriginForm._formKey,
            child: TextFormField(
              initialValue: widget.isEditing ? _origin : '',
              maxLines: 4,
              style: Theme.of(context).textTheme.subtitle1,
              decoration: InputDecoration(
                hintText: 'In che occasione o dove hai trovato questa domanda?',
              ),
              validator: (val) {
                return val.trim().isEmpty
                    ? 'Questo campo non può essere vuoto'
                    : null;
              },
              onSaved: (value) => question = question.copyWith(origin: value),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: 'Qual\'è l\'origine?',
            child: Icon(Icons.cloud_upload_outlined),
            onPressed: () {
              if (NewQuestionOriginForm._formKey.currentState.validate()) {
                NewQuestionOriginForm._formKey.currentState.save();
                context
                    .read<NewQuestionWizardBloc>()
                    .add(NewQuestionWizardOriginSubmitted(origin: _origin));

                context.read<QuestionsBloc>().add(AddQuestion(question));
              }
            }));
  }
}
