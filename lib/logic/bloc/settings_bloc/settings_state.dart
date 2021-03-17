part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  bool darkMode;

  SettingsState({this.darkMode = false});

  @override
  List<Object> get props => [darkMode];

  Map<String, dynamic> toMap() {
    return {
      'darkMode': darkMode,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      darkMode: map['darkMode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source));
}
