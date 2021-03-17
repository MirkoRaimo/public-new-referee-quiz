import 'package:flutter/material.dart';

//Routes
const String HOME_ROUTE = "/Home";
const String TRUE_FALSE_ROUTE = "/True_False";
const String QUIZ_ROUTE = "/Quiz";
const String RECAP_ANSWERS_ROUTE = "/RecapAnswersPage";
const String SETTINGS_ROUTE = "/SettingsPage";
const String LOGIN_ROUTE = "/LoginPage";

// Strings used
// (the app is for the italian market, so it doesn't need to be internationalized)
const String STR_QUIZ = "Quiz";
const String STR_TRUE = "Vero";
const String STR_FALSE = "Falso";
const String STR_IMPOSSIBLE = "Non è possibile";
const String STR_TRUE_OR_FALSE = "Vero o Falso";
const String STR_RIGHT = "Corretto";
const String STR_WRONG = "Sbagliato";
const String STR_WELCOME_SENTENCE = "Benvenuto! \nSeleziona una modalità";
const String STR_CORRECT_ANSWERS = "Risposte corrette:";
const String STR_DARK_MODE = "Dark Mode";

//Assets used (Paths)
const String PTH_LOGO_QUIZ = "assets/images/google_logo.png";
const String PTH_LOGO_TRUE_OR_FALSE = "assets/images/flutter_logo.png";

//Hero Tags
const String HERO_TRUE = "Fab Hero True";
const String HERO_FALSE = "Fab Hero Falso";

//App Name
const String APP_NAME = "Nuovo Quiz Arbitri";
const String SETTING_TITLE = "Settings";

//Dark Material Colours
const int _darkGreenPrimaryValue = 0xFF274E13; //colors._greenPrimaryValue

const MaterialColor DARK_GREEN = MaterialColor(
  _darkGreenPrimaryValue, //colors._greenPrimaryValue
  <int, Color>{
    50: Color(0xFFE5EAE3),
    100: Color(0xFFBECAB8),
    200: Color(0xFF93A789),
    300: Color(0xFF68835A),
    400: Color(0xFF476936),
    500: Color(_darkGreenPrimaryValue),
    600: Color(0xFF234711),
    700: Color(0xFF1D3D0E),
    800: Color(0xFF17350B),
    900: Color(0xFF0E2506),
  },
);

const int _darkGreen0AccentValue = 0xFF53FF2E;

const MaterialColor DARK_GREEN_ACCENT = MaterialColor(
    _darkGreen0AccentValue, <int, Color>{
  100: Color(0xFF7DFF61),
  200: Color(_darkGreen0AccentValue),
  400: Color(0xFF2CFA00),
  700: Color(0xFF27E100),
});
