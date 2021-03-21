import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/auth_bloc/authentication_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/personal_questions/personal_questions_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/questions_bloc/questions_bloc.dart';
import 'package:nuovoquizarbitri/logic/bloc/settings_bloc/settings_bloc.dart';
import 'package:nuovoquizarbitri/logic/cubit/login_cubit.dart';
import 'package:nuovoquizarbitri/logic/simple_bloc_observer.dart';
import 'package:nuovoquizarbitri/pages/home_page.dart';
import 'package:nuovoquizarbitri/pages/login_page.dart';
import 'package:nuovoquizarbitri/pages/new_question_page.dart';
import 'package:nuovoquizarbitri/pages/new_question_wizard.dart';
import 'package:nuovoquizarbitri/pages/quiz_page.dart';
import 'package:nuovoquizarbitri/pages/recap_answers_page.dart';
import 'package:nuovoquizarbitri/pages/settings_page.dart';
import 'package:nuovoquizarbitri/pages/true_false_page.dart';
import 'package:nuovoquizarbitri/redux/app/app_state.dart';
import 'package:nuovoquizarbitri/redux/store.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:questions_repository/questions_repository.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final String title = APP_NAME;

  final Store<AppState> store = createStore();

  final SettingsBloc _settingsBloc = new SettingsBloc();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  AuthenticationBloc _authenticationBloc;
  final QuestionsRepository _questionsRepository =
      FirebaseQuestionsRepository();

  @override
  void initState() {
    _authenticationBloc = new AuthenticationBloc(
      authenticationRepository: _authenticationRepository,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _settingsBloc,
          ),
          BlocProvider(
            create: (_) => _authenticationBloc,
          ),
          // BlocProvider(
          //   create: (_) => QuestionsBloc(
          //     questionsRepository: _questionsRepository,
          //   ),
          // )
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return MaterialApp(
              title: APP_NAME,
              debugShowCheckedModeBanner: false,
              theme: handleTheme(state),
              home: BlocProvider<AuthenticationBloc>.value(
                value: _authenticationBloc,
                child: HomePage(),
              ),
              routes: {
                HOME_ROUTE: (context) => HomePage(),
                QUIZ_ROUTE: (context) => QuizPage(),
                //TRUE_FALSE_ROUTE: (context) => TrueFalsePage(),
                TRUE_FALSE_ROUTE: (context) =>
                    BlocProvider<PersonalQuestionsBloc>(
                      create: (context) => PersonalQuestionsBloc(
                        questionsBloc: QuestionsBloc(
                          questionsRepository: FirebaseQuestionsRepository(
                              questionType: QuestionType.TRUE_FALSE),
                        ),
                      )..add(PLoadQuestions()),
                      child: TrueFalsePage(),
                    ),
                RECAP_ANSWERS_ROUTE: (context) => RecapAnswersPage(),
                LOGIN_ROUTE: (context) => LoginPage(),
                SETTINGS_ROUTE: (context) => BlocProvider<SettingsBloc>.value(
                      value: _settingsBloc,
                      child: SettingsPage(),
                    ),
                // NEW_QUESTION_ROUTE: (context) => NewQuestionPage(
                //       isEditing: false,
                //     ),
                NEW_QUESTION_ROUTE: (context) => NewQuestionWizard(),
              },
            );
          },
        ),
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
            primaryColor: DARK_GREEN,
            snackBarTheme: SnackBarThemeData(
              contentTextStyle: TextStyle(color: Colors.black),
            ))
        : ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.greenAccent,
            snackBarTheme: SnackBarThemeData(
              contentTextStyle: TextStyle(color: Colors.black),
            ));
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    _settingsBloc.close();
    super.dispose();
  }

  void updateRoute(AppState state, BuildContext context) {
    if (state.currentUser != null) {
      Navigator.pushNamed(context, '/');
    }
  }
}
