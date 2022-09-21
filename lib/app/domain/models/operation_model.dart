import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';

class OperationModel {
  final String? id;
  final String name;
  final UserModel organizer;
  final String? boss;
  final List<UserModel>? operators;
  final List<PersonModel>? involveds;
  final String? history;
  final bool isDeleted;
  bool? isSelected;
  OperationModel({
    this.id,
    required this.name,
    required this.organizer,
    this.boss,
    this.operators,
    this.involveds,
    this.history,
    this.isDeleted = false,
  });

  OperationModel copyWith({
    String? id,
    String? name,
    UserModel? organizer,
    String? boss,
    List<UserModel>? operators,
    List<PersonModel>? involved,
    String? history,
    bool? isDeleted,
  }) {
    return OperationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      organizer: organizer ?? this.organizer,
      boss: boss ?? this.boss,
      operators: operators ?? this.operators,
      involveds: involved ?? involveds,
      history: history ?? this.history,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'organizer': organizer.toMap()});
    if (boss != null) {
      result.addAll({'boss': boss});
    }
    if (operators != null) {
      result.addAll({'operators': operators!.map((x) => x.toMap()).toList()});
    }
    if (involveds != null) {
      result.addAll({'involved': involveds!.map((x) => x.toMap()).toList()});
    }
    if (history != null) {
      result.addAll({'history': history});
    }
    result.addAll({'isDeleted': isDeleted});

    return result;
  }

  factory OperationModel.fromMap(Map<String, dynamic> map) {
    return OperationModel(
      id: map['id'],
      name: map['name'] ?? '',
      organizer: UserModel.fromMap(map['organizer']),
      boss: map['boss'],
      operators: map['operators'] != null
          ? List<UserModel>.from(
              map['operators']?.map((x) => UserModel.fromMap(x)))
          : null,
      involveds: map['involved'] != null
          ? List<PersonModel>.from(
              map['involved']?.map((x) => PersonModel.fromMap(x)))
          : null,
      history: map['history'],
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory OperationModel.fromJson(String source) =>
      OperationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OperationModel(id: $id, name: $name, organizer: $organizer, boss: $boss, operators: $operators, involved: $involveds, history: $history, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OperationModel &&
        other.id == id &&
        other.name == name &&
        other.organizer == organizer &&
        other.boss == boss &&
        listEquals(other.operators, operators) &&
        listEquals(other.involveds, involveds) &&
        other.history == history &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        organizer.hashCode ^
        boss.hashCode ^
        operators.hashCode ^
        involveds.hashCode ^
        history.hashCode ^
        isDeleted.hashCode;
  }
}
