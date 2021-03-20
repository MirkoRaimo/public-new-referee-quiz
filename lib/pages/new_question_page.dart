import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/questions_bloc/questions_bloc.dart';
import 'package:questions_repository/questions_repository.dart';

typedef OnSaveCallback = Function(String task, String note);

class NewQuestionPage extends StatefulWidget {
  final bool isEditing;
  //final OnSaveCallback onSave = BlocProvider.of<QuestionsBloc>(context).add(AddQuestion(question));

  NewQuestionPage({Key key, this.isEditing}) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _NewQuestionPageState createState() => _NewQuestionPageState();
}

enum SingingCharacter { lafayette, jefferson }

class _NewQuestionPageState extends State<NewQuestionPage> {
  final Question question = new Question();

  String _task;

  String _note;

  bool _trueOrFalseQuestion = true;

  final String _possibleAnswers = 'possibleAnswers';

  String _correctAnswer = 'true';

  int value;

  SingingCharacter _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Modifica una Domanda' : 'Proponi una domanda',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: NewQuestionPage._formKey,
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
                onSaved: (value) => _note = value,
              ),
              SwitchListTile.adaptive(
                  title: Text('Vero o Falso?'),
                  value: _trueOrFalseQuestion,
                  onChanged: (value) => setState(() {
                        _trueOrFalseQuestion = value;
                      })),
              Visibility(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue:
                          widget.isEditing ? question.questionStatement : '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1,
                      decoration: InputDecoration(
                        hintText: 'Risposta 1',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'Questo campo non può essere vuoto'
                            : null;
                      },
                      onSaved: (value) => _note = value,
                    ),
                    TextFormField(
                      initialValue:
                          widget.isEditing ? question.questionStatement : '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1,
                      decoration: InputDecoration(
                        hintText: 'Risposta 2',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'Questo campo non può essere vuoto'
                            : null;
                      },
                      onSaved: (value) => _note = value,
                    ),
                    TextFormField(
                      initialValue:
                          widget.isEditing ? question.questionStatement : '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1,
                      decoration: InputDecoration(
                        hintText: 'Risposta 3',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'Questo campo non può essere vuoto'
                            : null;
                      },
                      onSaved: (value) => _note = value,
                    ),
                    TextFormField(
                      initialValue:
                          widget.isEditing ? question.questionStatement : '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1,
                      decoration: InputDecoration(
                        hintText: 'Risposta 4',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'Questo campo non può essere vuoto'
                            : null;
                      },
                      onSaved: (value) => _note = value,
                    ),
                  ],
                ),
                visible: !_trueOrFalseQuestion,
              ),
              // Column(
              //   children: <Widget>[
              //     RadioListTile(
              //       title: const Text('Lafayette'),
              //       value: SingingCharacter.lafayette,
              //       groupValue: _character,
              //       onChanged: (SingingCharacter value) {
              //         setState(() {
              //           _character = value;
              //         });
              //       },
              //     ),
              //     RadioListTile(
              //       title: const Text('Thomas Jefferson'),
              //       value: SingingCharacter.jefferson,
              //       groupValue: _character,
              //       onChanged: (SingingCharacter value) {
              //         setState(() {
              //           _character = value;
              //         });
              //       },
              //     ),
              //   ],
              // ),

              ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    value: index,
                    groupValue: value,
                    onChanged: (ind) => setState(() => value = ind),
                    title: Text("Number $index"),
                  );
                },
                itemCount: 3,
              ),
              TextFormField(
                initialValue: '',
                autofocus: !widget.isEditing,
                style: Theme.of(context).textTheme.headline5,
                decoration: InputDecoration(
                  hintText: 'What needs to be done?',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (value) => _task = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEditing ? 'Save changes' : 'Add Todo',
        child: Icon(widget.isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (NewQuestionPage._formKey.currentState.validate()) {
            NewQuestionPage._formKey.currentState.save();
            //onSave(_task, _note);

            BlocProvider.of<QuestionsBloc>(context)
                .add(AddQuestion(question.copyWith(questionStatement: _note)));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
