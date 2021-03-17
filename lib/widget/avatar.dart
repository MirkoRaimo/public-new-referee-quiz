import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/auth_bloc/authentication_bloc.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';

const _avatarSize = 23.0;

class Avatar extends StatelessWidget {
  const Avatar({Key key, this.photo}) : super(key: key);

  final String photo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state.status == AuthenticationStatus.authenticated) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LOGIN_ROUTE);
            },
            child: CircleAvatar(
              radius: _avatarSize,
              backgroundImage: NetworkImage(state.user.photo),
            ),
          ),
        );
      }
      return IconButton(
        icon: Icon(Icons.person_outline),
        onPressed: () {
          Navigator.pushNamed(context, LOGIN_ROUTE);
        },
      );
    });
  }
}
