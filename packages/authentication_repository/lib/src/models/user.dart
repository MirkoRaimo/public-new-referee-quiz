import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    this.email,
    this.id,
    required this.name,
    required this.photo,
  })   : assert(email != null),
        assert(id != null);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email']?.toString(),
      id: map['id']?.toString(),
      name: map['name']?.toString() ?? 'unknown',
      photo: map['photo']?.toString() ?? 'unknown',
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String? id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(email: '', id: '', name: null, photo: null);

  @override
  List<Object?> get props => [email, id, name, photo];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'id': id,
      'name': name,
      'photo': photo,
    };
  }

  String toJson() => json.encode(toMap());

  Map<String, String> toNestedJson() => {
        'email': email?.toString() ?? '',
        'id': id?.toString() ?? '',
        'name': name?.toString() ?? '',
        'photo': photo?.toString() ?? '',
      };
}
