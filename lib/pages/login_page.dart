import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nuovoquizarbitri/logic/bloc/auth_bloc/authentication_bloc.dart';
import 'package:nuovoquizarbitri/logic/cubit/login_cubit.dart';
import 'package:nuovoquizarbitri/pages/home_page.dart';
import 'package:nuovoquizarbitri/widget/avatar.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    final double _sixedBoxHeight = 32.0;
    final _authState =
        context.select((AuthenticationBloc bloc) => bloc.state.status);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          actions: [Avatar()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              //child: _authState == AuthenticationStatus.authenticated

              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) =>
                      state.status == AuthenticationStatus.authenticated
                          ? _logoutColumn(_sixedBoxHeight, context)
                          : _loginColumn(_sixedBoxHeight, context))

              // BlocListener<AuthenticationBloc, AuthenticationState>(
              //     listener: (context, state) {
              //   state.status != null &&
              //           state.status == AuthenticationStatus.authenticated
              //       ? _logoutColumn(_sixedBoxHeight, context)
              //       : _loginColumn(_sixedBoxHeight, context);
              // })),
              ),
        ));
  }

  Column _logoutColumn(double _sixedBoxHeight, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _sixedBoxHeight,
        ),
        Text(
          "Sicuro di voler effettuare il logout?",
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: _sixedBoxHeight,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GoogleLogoutButton(),
          ],
        ),
      ],
    );
  }

  Column _loginColumn(double _sixedBoxHeight, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _sixedBoxHeight,
        ),
        Text(
          "Non sei ancora autenticato?\nFallo ora!",
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: _sixedBoxHeight,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GoogleLoginButton(),
          ],
        ),
      ],
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return ElevatedButton.icon(
        key: const Key('loginForm_googleLogin_raisedButton'),
        label: const Text(
          'SIGN IN WITH GOOGLE',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          //primary: theme.accentColor,
        ),
        icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
        onPressed: () {
          context.read<LoginCubit>().logInWithGoogle().then((value) =>
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => HomePage()),
                  (route) => false));
        });
  }
}

class _GoogleLogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return ElevatedButton.icon(
        key: const Key('loginForm_googleLogout_raisedButton'),
        label: const Text(
          'Logout with Google',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          //primary: theme.accentColor,
        ),
        icon: const Icon(Icons.exit_to_app),
        onPressed: () {
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationLogoutRequested());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (c) => HomePage()), (route) => false);
        });
  }
}
