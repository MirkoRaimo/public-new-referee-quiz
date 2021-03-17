part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ToggleDarkMode extends SettingsEvent {
  final bool activated;

  ToggleDarkMode(this.activated);
}
