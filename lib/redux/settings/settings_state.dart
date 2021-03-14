import 'package:flutter/cupertino.dart';

@immutable
class SettingsState{
  final BuildContext context;
  final bool darkMode;

  SettingsState({this.context, this.darkMode});

  SettingsState copyWith({BuildContext context, bool darkMode}){
    return new SettingsState(
        context: context ?? this.context,
        darkMode: darkMode ?? this.darkMode
    );
  }

  factory SettingsState.initial(){
    return SettingsState(darkMode: false);
  }
}