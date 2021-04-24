import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  // Singleton instance
  static final AppDatabase _singleton = AppDatabase._();

  // Singleton accessor
  static AppDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  AppDatabase._();

  // Sembast database object
  Database _database;

  // Database object accessor
  Future<Database> get database async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also complete the completer with database instance
      _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'demo.db');

    // Our shop store sample data
    var store = intMapStoreFactory.store('local_db_collection');
    await databaseFactoryIo.deleteDatabase(dbPath); //TODO: ELIMINATE THIS ROW
// final database = await databaseFactoryIo.openDatabase(dbPath);
    final database = await databaseFactoryIo.openDatabase(dbPath, version: 2,
        onVersionChanged: (db, oldVersion, newVersion) async {
      // if (oldVersion == 0) {

      // await store.add(db, {
      //   "questionStatement":
      //       "Con il pallone in gioco, un portiere effettua con i piedi dei segni non autorizzati sul terreno di gioco, prolungando le linee perpendicolari che delimitano l’area di porta, al fine di meglio orientarsi. L’Arbitro ...",
      //   "answerStatement":
      //       "... attende la prima interruzione di gioco ed ammonisce il portiere per comportamento antisportivo",
      //   "possibleAnswers": ["Vero", "Falso"],
      //   "correctAnswer": 0,
      //   "givenAnswer": null,
      //   "origin": "Amanda did test",
      //   "trueFalseQuestion": true
      // });
      //
      await store.addAll(db, [
        {
          "rule": 1,
          "questionStatement":
              "Con il pallone in gioco, un portiere effettua con i piedi dei segni non autorizzati sul terreno di gioco, prolungando le linee perpendicolari che delimitano l’area di porta, al fine di meglio orientarsi. L’Arbitro ...",
          "strCorrectAnswer":
              "... attende la prima interruzione di gioco ed ammonisce il portiere per comportamento antisportivo",
          "possibleAnswers": ["Vero", "Falso"],
          // "correctAnswer": 0,
          "givenAnswer": null,
          "origin": "Domande ufficiali 2019-2020",
          // "trueFalseQuestion": true
        },
        {
          "rule": 1,
          "questionStatement":
              "Di norma le Società di Eccellenza sono obbligate a provvedere allo sgombero della neve fino a 48 ore prima dell’orario ufficiale previsto per l’inizio della gara",
          "strCorrectAnswer": "FALSO",
          "possibleAnswers": ["Vero", "Falso"],
          // "correctAnswer": 0,
          "givenAnswer": null,
          "origin": "Domande ufficiali 2019-2020",
          // "trueFalseQuestion": true
        },
        {
          "rule": 1,
          "questionStatement":
              "Con il pallone in gioco, un portiere effettua con i piedi dei segni non autorizzati sul terreno di gioco, prolungando le linee perpendicolari che delimitano l’area di porta, al fine di meglio orientarsi. L’Arbitro ...",
          "strCorrectAnswer":
              "... attende la prima interruzione di gioco ed ammonisce il portiere per comportamento antisportivo",
          "possibleAnswers": ["Vero", "Falso"],
          // "correctAnswer": 0,
          "givenAnswer": null,
          "origin": "Domande ufficiali 2019-2020",
          // "trueFalseQuestion": true
        },
        {
          "key": "2",
          "rule": "1",
          "questionStatement":
              "Di norma le Società di Eccellenza sono obbligate a provvedere allo sgombero della neve fino a 48 ore prima dell’orario ufficiale previsto per l’inizio della gara",
          "strCorrectAnswer": "FALSO",
          "possibleAnswers": ["Vero", "Falso"],
          // "correctAnswer": 0,
          "givenAnswer": null,
          "origin": "Domande ufficiali 2019-2020",
          // "trueFalseQuestion": true
        }
      ]);

      Future<List<Map<String, Object>>> getProductMaps() async {
        var results = await store
            .stream(db)
            .map((snapshot) =>
                Map<String, Object>.from(snapshot.value)..['id'] = snapshot.key)
            .toList();
        return results;
      }

      print("🎉🎉🎉🎉🎉🎉🎉🎉" + getProductMaps().toString());
    });
    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter.complete(database);
  }

  //   // final database = await databaseFactoryIo.openDatabase(dbPath);
  //   final database = await databaseFactoryIo.openDatabase(dbPath, version: 1,
  //       onVersionChanged: (db, oldVersion, newVersion) async {
  //     // if (oldVersion == 0) {

  //     await store.add(db, {
  //       "questionStatement":
  //           "Con il pallone in gioco, un portiere effettua con i piedi dei segni non autorizzati sul terreno di gioco, prolungando le linee perpendicolari che delimitano l’area di porta, al fine di meglio orientarsi. L’Arbitro ...",
  //       "answerStatement":
  //           "... attende la prima interruzione di gioco ed ammonisce il portiere per comportamento antisportivo",
  //       "possibleAnswers": ["Vero", "Falso"],
  //       "correctAnswer": "0",
  //       "givenAnswer": null,
  //       "origin": "Amanda did test",
  //       "trueFalseQuestion": true
  //     });

  //     Future<List<Map<String, Object>>> getProductMaps() async {
  //       var results = await store
  //           .stream(db)
  //           .map((snapshot) =>
  //               Map<String, Object>.from(snapshot.value)..['id'] = snapshot.key)
  //           .toList();
  //       return results;
  //     }

  //     print("🎉🎉🎉🎉🎉🎉🎉🎉" + getProductMaps().toString());

  //     // await store.add(db, {
  //     //   "key": "1",
  //     //   "rule": "1",
  //     //   "store": "local_db_collection",
  //     //   "value": {
  //     //     "questionStatement":
  //     //         "Con il pallone in gioco, un portiere effettua con i piedi dei segni non autorizzati sul terreno di gioco, prolungando le linee perpendicolari che delimitano l’area di porta, al fine di meglio orientarsi. L’Arbitro ...",
  //     //     "answerStatement":
  //     //         "... attende la prima interruzione di gioco ed ammonisce il portiere per comportamento antisportivo",
  //     //     "possibleAnswers": ["Vero", "Falso"],
  //     //     "correctAnswer": "0",
  //     //     "givenAnswer": null,
  //     //     "origin": "Amanda did test",
  //     //     "trueFalseQuestion": true
  //     //   }
  //     // });
  //     // }
  //   });
  //   // Any code awaiting the Completer's future will now start executing
  //   _dbOpenCompleter.complete(database);
  // }
}
