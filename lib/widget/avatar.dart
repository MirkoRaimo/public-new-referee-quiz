import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/auth_bloc/authentication_bloc.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';

const _avatarSize = 23.0;

class Avatar extends StatelessWidget {
  const Avatar({Key key, this.photo, this.disableOnPressed = false})
      : super(key: key);
  final bool disableOnPressed;
  final String photo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state.status == AuthenticationStatus.authenticated) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _handleTap(context),
            child: CircleAvatar(
              radius: _avatarSize,
              backgroundImage: NetworkImage(state.user.photo),
            ),
          ),
        );
      }
      return IconButton(
        icon: Icon(Icons.person_outline),
        onPressed: () => _handleTap(context),
        splashColor: disableOnPressed ? Colors.transparent : null,
        highlightColor: disableOnPressed ? Colors.transparent : null,
      );
    });
  }

  void _handleTap(BuildContext context) {
    if (!disableOnPressed) {
      Navigator.pushNamed(context, LOGIN_ROUTE);
    }
  }
}
