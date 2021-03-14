import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nuovoquizarbitri/logic/bloc/settings_bloc.dart';
import 'package:nuovoquizarbitri/redux/app/app_state.dart';
import 'package:nuovoquizarbitri/redux/settings/settings_actions.dart';

import 'package:provider/provider.dart';
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
        //onChanged: (value) => StoreProvider.of<AppState>(context).dispatch(SetDarkMode(darkMode: value))),
      ],
    );
  }

// HANDLED WITH REDUX

  // @override
  // Widget build(BuildContext context) {
  //   return StoreConnector<AppState, SettingsState>(
  //       distinct: true, //to improve the performances
  //       converter: (store) => store.state.settingsState,
  //       builder: (BuildContext context, SettingsState settingsState) {
  //         return Scaffold(
  //           appBar: AppBar(
  //             title: SelectableText(title),
  //           ),
  //           body: _buildBody(context, settingsState),
  //         );
  //       });
  // }

  // Column _buildBody(BuildContext context, SettingsState settingsState) {
  //   return Column(
  //     children: [
  //       SwitchListTile.adaptive(
  //         title: Text(STR_DARK_MODE),
  //         value: settingsState.darkMode,
  //         onChanged: (value) => StoreProvider.of<AppState>(context).dispatch(SetDarkMode(darkMode: value))
  //       ),
  //     ],
  //   );
  // }
}
