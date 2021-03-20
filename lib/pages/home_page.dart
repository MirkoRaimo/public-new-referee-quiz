import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/auth_bloc/authentication_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/questions_bloc/questions_bloc.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';
import 'package:nuovoquizarbitri/widget/avatar.dart';
import 'package:nuovoquizarbitri/widget/home_grid.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.photo}) : super(key: key);
  final String title = APP_NAME;
  final String photo;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, SETTINGS_ROUTE);
            },
          ),
          title: SelectableText(widget.title),
          actions: <Widget>[
            Avatar(
              photo: widget.photo,
            ),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.status == AuthenticationStatus.unauthenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).accentColor,
                      duration: Duration(milliseconds: 1000),
                      content: Text('Logout effettuato con successo'),
                    ),
                  );
                }
                if (state.status == AuthenticationStatus.authenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).accentColor,
                      duration: Duration(milliseconds: 1000),
                      content: Text('Login effettuato con successo'),
                    ),
                  );
                }
              },
            )
            // BlocListener<QuestionsBloc, QuestionsState>(
            //   listener: (context, state) {
            //     if ( == AuthenticationStatus.authenticated) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       backgroundColor: Theme.of(context).accentColor,
            //       duration: Duration(milliseconds: 1000),
            //       content: Text('Login effettuato con successo'),
            //     ),
            //   );
            //   },
            // ),
          ],
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Flexible(
                  flex: 1,
                  child: SelectableText(
                    STR_WELCOME_SENTENCE,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  )),
              Flexible(flex: 2, child: Center(child: homeGrid(context))),
            ],
          ),
        ));
  }
}
