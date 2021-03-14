import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/settings_bloc.dart';
import 'package:nuovoquizarbitri/logic/simple_bloc_observer.dart';
import 'package:nuovoquizarbitri/pages/home_page.dart';
import 'package:nuovoquizarbitri/pages/quiz_page.dart';
import 'package:nuovoquizarbitri/pages/recap_answers_page.dart';
import 'package:nuovoquizarbitri/pages/settings_page.dart';
import 'package:nuovoquizarbitri/pages/true_false_page.dart';
import 'package:nuovoquizarbitri/redux/app/app_state.dart';
import 'package:nuovoquizarbitri/redux/store.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String title = APP_NAME;

  final Store<AppState> store = createStore();

  final SettingsBloc _settingsBloc = new SettingsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _settingsBloc,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: title,
            debugShowCheckedModeBanner: false,
            theme: handleTheme(state),
            home: HomePage(title: title),
            routes: {
              HOME_ROUTE: (context) => HomePage(title: title),
              QUIZ_ROUTE: (context) => QuizPage(),
              TRUE_FALSE_ROUTE: (context) => TrueFalsePage(),
              RECAP_ANSWERS_ROUTE: (context) => RecapAnswersPage(),
              SETTINGS_ROUTE: (context) => BlocProvider.value(
                    value: _settingsBloc,
                    child: SettingsPage(),
                  )
            },
          );
        },
      ),
    );

/*
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, SettingsState>(
          distinct: true, //to improve the performances
          converter: (store) => store.state.settingsState,
          builder: (BuildContext context, SettingsState settingsState) {
            return MaterialApp(
              title: title,
              debugShowCheckedModeBanner: false,
              theme: _handleInitialDarkMode(
                      context, store.state.settingsState.darkMode)
                  ? ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: DARK_GREEN,
                      accentColor: DARK_GREEN_ACCENT,
                      primaryColor: DARK_GREEN)
                  : ThemeData(
                      primarySwatch: Colors.green,
                      accentColor: Colors.greenAccent),
              home: HomePage(title: title),
              routes: {
                HOME_ROUTE: (context) => HomePage(title: title),
                QUIZ_ROUTE: (context) => QuizPage(),
                TRUE_FALSE_ROUTE: (context) => TrueFalsePage(),
                RECAP_ANSWERS_ROUTE: (context) => RecapAnswersPage(),
                SETTINGS_ROUTE: (context) => SettingsPage(),
              },
            );
          }),
    );
*/
  }

  ThemeData handleTheme(SettingsState state) {
    return state.darkMode
        ? ThemeData(
            brightness: Brightness.dark,
            primarySwatch: DARK_GREEN,
            accentColor: DARK_GREEN_ACCENT,
            primaryColor: DARK_GREEN)
        : ThemeData(
            primarySwatch: Colors.green, accentColor: Colors.greenAccent);
  }

  @override
  void dispose() {
    _settingsBloc.close();
    super.dispose();
  }

  void updateRoute(AppState state, BuildContext context) {
    if (state.currentUser != null) {
      Navigator.pushNamed(context, '/');
    }
  }
}
