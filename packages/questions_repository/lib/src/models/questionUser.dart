import 'package:equatable/equatable.dart';

/// {@template questionUser}
/// QuestionUser model
///
/// This model represents the data of a user associated to each question
/// {@endtemplate}
class QuestionUser extends Equatable {
  /// {@macro questionUser}
  const QuestionUser({
    this.email,
    this.id,
    this.name,
    this.photo,
  })  : assert(email != null),
        assert(id != null);

  /// The current questionUser's email address.
  final String email;

  /// The current questionUser's id.
  final String id;

  /// The current questionUser's name (display name).
  final String name;

  /// Url for the current questionUser's photo.
  final String photo;

  /// Empty questionUser which represents an unauthenticated questionUser.
  static const empty = QuestionUser(email: '', id: '', name: null, photo: null);

  @override
  List<Object> get props => [email, id, name, photo];
}
