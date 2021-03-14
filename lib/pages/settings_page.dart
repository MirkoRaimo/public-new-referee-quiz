import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/settings_bloc.dart';

import 'package:nuovoquizarbitri/utils/constants.dart';

class SettingsPage extends StatelessWidget {
  final String title = SETTING_TITLE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText(title),
      ),
      body: _buildBody(context),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return SwitchListTile.adaptive(
              title: Text(STR_DARK_MODE),
              value: state.darkMode,
              onChanged: (value) => BlocProvider.of<SettingsBloc>(context)
                  .add(ToggleDarkMode(value)),
            );
          },
        )
      ],
    );
  }
}
