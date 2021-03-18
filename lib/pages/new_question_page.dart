import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/questions_bloc/questions_bloc.dart';
import 'package:questions_repository/questions_repository.dart';

typedef OnSaveCallback = Function(String task, String note);

class NewQuestionPage extends StatelessWidget {
  final bool isEditing;
  //final OnSaveCallback onSave = BlocProvider.of<QuestionsBloc>(context).add(AddQuestion(question));
  final Question question = new Question();

  NewQuestionPage({Key key, this.isEditing}) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Todo' : 'Add Todo',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: '',
                autofocus: !isEditing,
                style: Theme.of(context).textTheme.headline5,
                decoration: InputDecoration(
                  hintText: 'What needs to be done?',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: isEditing ? question.questionStatement : '',
                maxLines: 10,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: 'Additional Notes...',
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'Save changes' : 'Add Todo',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
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
