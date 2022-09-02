// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:noctua/app/domain/models/person_model.dart';

class PersonImageModel {
  final String? id;
  final String? photo;
  final PersonModel person;
  final bool? isDeleted;
  PersonImageModel({
    this.id,
    this.photo,
    required this.person,
    this.isDeleted,
  });

  PersonImageModel copyWith({
    String? id,
    String? photo,
    PersonModel? person,
    bool? isDeleted,
  }) {
    return PersonImageModel(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      person: person ?? this.person,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
    }
    result.addAll({'person': person.toMap()});
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory PersonImageModel.fromMap(Map<String, dynamic> map) {
    return PersonImageModel(
      id: map['id'],
      photo: map['photo'],
      person: PersonModel.fromMap(map['person']),
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonImageModel.fromJson(String source) =>
      PersonImageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonImageModel(id: $id, photo: $photo, person: $person, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonImageModel &&
        other.id == id &&
        other.photo == photo &&
        other.person == person &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^ photo.hashCode ^ person.hashCode ^ isDeleted.hashCode;
  }
}
