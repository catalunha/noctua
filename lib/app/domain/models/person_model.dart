import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:noctua/app/domain/models/user_model.dart';

class PersonModel {
  final String? id;
  final UserModel user;
  final String? name;
  final bool isMale;
  final List<String> alias;
  final String? history;
  PersonModel({
    this.id,
    required this.user,
    this.name,
    required this.isMale,
    required this.alias,
    this.history,
  });

  PersonModel copyWith({
    String? id,
    UserModel? user,
    String? name,
    bool? isMale,
    List<String>? alias,
    String? history,
  }) {
    return PersonModel(
      id: id ?? this.id,
      user: user ?? this.user,
      name: name ?? this.name,
      isMale: isMale ?? this.isMale,
      alias: alias ?? this.alias,
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'name': name,
      'isMale': isMale,
      'alias': alias,
      'history': history,
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      id: map['id'],
      user: UserModel.fromMap(map['user']),
      name: map['name'],
      isMale: map['isMale'] ?? false,
      alias: List<String>.from(map['alias']),
      history: map['history'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) =>
      PersonModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonModel(id: $id, user: $user, name: $name, isMale: $isMale, alias: $alias, history: $history)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonModel &&
        other.id == id &&
        other.user == user &&
        other.name == name &&
        other.isMale == isMale &&
        listEquals(other.alias, alias) &&
        other.history == history;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        name.hashCode ^
        isMale.hashCode ^
        alias.hashCode ^
        history.hashCode;
  }
}
