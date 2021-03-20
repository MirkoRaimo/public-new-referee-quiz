import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/auth_bloc/authentication_bloc.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';

Widget homeGrid(BuildContext context) {
  final AuthenticationStatus userStatus =
      context.watch<AuthenticationBloc>().state.status;

  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: <Widget>[
      homeGridElement(context, STR_QUIZ, PTH_LOGO_QUIZ, QUIZ_ROUTE),
      homeGridElement(
          context, STR_TRUE_OR_FALSE, PTH_LOGO_TRUE_OR_FALSE, TRUE_FALSE_ROUTE),
      homeGridElement(
          context, STR_NEW_QUESTION, PTH_LOGO_NEW_QUESTION, NEW_QUESTION_ROUTE,
          disableButton: userStatus != AuthenticationStatus.authenticated,
          alternativeRoot: LOGIN_ROUTE),
    ],
  );
}

Widget homeGridElement(BuildContext context, String elementName,
    String assetImage, String namedRoute,
    {List<Object> arguments,
    bool disableButton = false,
    String alternativeRoot}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
        child: Card(
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(assetImage)))),
              Flexible(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(elementName),
                  ))
            ],
          ),
          elevation: 18.0,
          clipBehavior: Clip.antiAlias,
        ),
        onTap: () {
          if (!disableButton) {
            namedRoute != null
                ? Navigator.pushNamed(context, namedRoute, arguments: arguments)
                : Navigator.pushNamed(context, namedRoute);
          } else if (alternativeRoot != null && alternativeRoot.isNotEmpty) {
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).accentColor,
                  duration: Duration(milliseconds: 3000),
                  content: Text(
                    'Devi effettuare il login per usare questa funzionalità',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
              Navigator.pushNamed(context, alternativeRoot);
            }
          }
        }),
  );
}
