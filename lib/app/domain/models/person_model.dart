// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';

class PersonModel {
  final String? id;
  final UserModel user;
  final bool isMale;
  final String? name;
  final List<String>? alias;
  final String? mother;
  final String? note;
  final String? history;
  final String? photo;
  final String? cpf;
  final DateTime? birthday;
  final List<LawModel>? laws;
  final List<PersonImageModel>? images;

  final bool isArchived;
  final bool isDeleted;
  final bool isPublic;
  PersonModel({
    this.id,
    required this.user,
    this.isMale = true,
    this.name,
    this.alias,
    this.mother,
    this.note,
    this.history,
    this.photo,
    this.cpf,
    this.birthday,
    this.laws,
    this.images,
    this.isArchived = false,
    this.isDeleted = false,
    this.isPublic = false,
  });

  PersonModel copyWith({
    String? id,
    UserModel? user,
    bool? isMale,
    String? name,
    List<String>? alias,
    String? mother,
    String? note,
    String? history,
    String? photo,
    String? cpf,
    DateTime? birthday,
    List<LawModel>? laws,
    List<PersonImageModel>? images,
    bool? isArchived,
    bool? isDeleted,
    bool? isPublic,
  }) {
    return PersonModel(
      id: id ?? this.id,
      user: user ?? this.user,
      isMale: isMale ?? this.isMale,
      name: name ?? this.name,
      alias: alias ?? this.alias,
      mother: mother ?? this.mother,
      note: note ?? this.note,
      history: history ?? this.history,
      photo: photo ?? this.photo,
      cpf: cpf ?? this.cpf,
      birthday: birthday ?? this.birthday,
      laws: laws ?? this.laws,
      images: images ?? this.images,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      isPublic: isPublic ?? this.isPublic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'isMale': isMale,
      'name': name,
      'alias': alias,
      'mother': mother,
      'note': note,
      'history': history,
      'photo': photo,
      'cpf': cpf,
      'birthday': birthday,
      'laws': laws?.map((x) => x.toMap()).toList(),
      'images': images?.map((x) => x.toMap()).toList(),
      'isArchived': isArchived,
      'isDeleted': isDeleted,
      'isPublic': isPublic,
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      id: map['id'] != null ? map['id'] as String : null,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      isMale: map['isMale'] as bool,
      name: map['name'] != null ? map['name'] as String : null,
      alias: map['alias'] != null
          ? List<String>.from((map['alias'] as List<String>))
          : null,
      mother: map['mother'] != null ? map['mother'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      history: map['history'] != null ? map['history'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      birthday: map['birthday'],
      laws: map['laws'] != null
          ? List<LawModel>.from(map['laws']?.map((x) => LawModel.fromMap(x)))
          : null,
      images: map['images'] != null
          ? List<PersonImageModel>.from(
              map['images']?.map((x) => PersonImageModel.fromMap(x)))
          : null,
      isArchived: map['isArchived'] as bool,
      isDeleted: map['isDeleted'] as bool,
      isPublic: map['isPublic'] as bool,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory PersonModel.fromJson(String source) =>
  //     PersonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonModel(id: $id, user: $user, isMale: $isMale, name: $name, alias: $alias, mother: $mother, note: $note, history: $history, photo: $photo, cpf: $cpf, birthday: $birthday, laws: $laws, images: $images, isArchived: $isArchived, isDeleted: $isDeleted, isPublic: $isPublic)';
  }

  @override
  bool operator ==(covariant PersonModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.isMale == isMale &&
        other.name == name &&
        listEquals(other.alias, alias) &&
        other.mother == mother &&
        other.note == note &&
        other.history == history &&
        other.photo == photo &&
        other.cpf == cpf &&
        other.birthday == birthday &&
        listEquals(other.laws, laws) &&
        listEquals(other.images, images) &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted &&
        other.isPublic == isPublic;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        isMale.hashCode ^
        name.hashCode ^
        alias.hashCode ^
        mother.hashCode ^
        note.hashCode ^
        history.hashCode ^
        photo.hashCode ^
        cpf.hashCode ^
        birthday.hashCode ^
        laws.hashCode ^
        images.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode ^
        isPublic.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) =>
      PersonModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
