import 'package:questions_repository/questions_repository.dart';
import 'package:questions_repository/src/sembast/app_database.dart';
import 'package:sembast/sembast.dart';

// final String trueFalseCollection =
//     FirebaseFirestore.instance.collection('true_false_questions');
// final String multiAnswCollection =
//     FirebaseFirestore.instance.collection('multi_answ_questions');

class LocalQuestionsRepository implements QuestionsRepository {
  static const String LOCAL_DB_COLLECTION = 'local_db_collection';

  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _localStore = intMapStoreFactory.store(LOCAL_DB_COLLECTION);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  @override
  Future<void> addNewQuestion(Question question) async {
    await _localStore.add(await _db, question.toMap());
  }

  @override
  Future<void> deleteQuestion(Question question) async {
    final finder = Finder(filter: Filter.byKey(question.id));
    await _localStore.delete(
      await _db,
      finder: finder,
    );
  }

  @override
  Future<void> updateQuestion(Question question) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(question.id));
    await _localStore.update(
      await _db,
      question.toMap(),
      finder: finder,
    );
  }

  @override
  Stream<List<Question>> questions() {
    return streamFromFuture(futureQuestions());
  }

  Stream<List<Question>> trueFalsequestions() {
    return streamFromFuture(futureQuestions());
  }

  Stream<T> streamFromFuture<T>(Future<T> future) async* {
    var result = await future;
    yield result;
  }

  Stream<T> streamFromFutures<T>(Iterable<Future<T>> futures) async* {
    for (var future in futures) {
      var result = await future;
      yield result;
    }
  }

  Future<List<Question>> futureQuestions() async {
    final finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);

    final recordSnapshots = await _localStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<Fruit> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final question = Question.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      //question = question.copyWith(id: snapshot.key);
      return question;
    }).toList();
  }
}
