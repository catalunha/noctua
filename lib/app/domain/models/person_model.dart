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
  final List<String>? nameWords;
  final List<String>? alias;
  final String? mother;
  final List<String>? motherWords;
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
    this.nameWords,
    this.alias,
    this.mother,
    this.motherWords,
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
    List<String>? nameWords,
    List<String>? alias,
    String? mother,
    List<String>? motherWords,
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
      nameWords: nameWords ?? this.nameWords,
      alias: alias ?? this.alias,
      mother: mother ?? this.mother,
      motherWords: motherWords ?? this.motherWords,
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
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'user': user.toMap()});
    result.addAll({'isMale': isMale});
    if (name != null) {
      result.addAll({'name': name});
    }
    if (nameWords != null) {
      result.addAll({'nameWords': nameWords});
    }
    if (alias != null) {
      result.addAll({'alias': alias});
    }
    if (mother != null) {
      result.addAll({'mother': mother});
    }
    if (motherWords != null) {
      result.addAll({'motherWords': motherWords});
    }
    if (note != null) {
      result.addAll({'note': note});
    }
    if (history != null) {
      result.addAll({'history': history});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
    }
    if (cpf != null) {
      result.addAll({'cpf': cpf});
    }
    if (birthday != null) {
      result.addAll({'birthday': birthday!.millisecondsSinceEpoch});
    }
    if (laws != null) {
      result.addAll({'laws': laws!.map((x) => x.toMap()).toList()});
    }
    if (images != null) {
      result.addAll({'images': images!.map((x) => x.toMap()).toList()});
    }
    result.addAll({'isArchived': isArchived});
    result.addAll({'isDeleted': isDeleted});
    result.addAll({'isPublic': isPublic});

    return result;
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      id: map['id'],
      user: UserModel.fromMap(map['user']),
      isMale: map['isMale'] ?? false,
      name: map['name'],
      nameWords: List<String>.from(map['nameWords']),
      alias: List<String>.from(map['alias']),
      mother: map['mother'],
      motherWords: List<String>.from(map['motherWords']),
      note: map['note'],
      history: map['history'],
      photo: map['photo'],
      cpf: map['cpf'],
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'])
          : null,
      laws: map['laws'] != null
          ? List<LawModel>.from(map['laws']?.map((x) => LawModel.fromMap(x)))
          : null,
      images: map['images'] != null
          ? List<PersonImageModel>.from(
              map['images']?.map((x) => PersonImageModel.fromMap(x)))
          : null,
      isArchived: map['isArchived'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
      isPublic: map['isPublic'] ?? false,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory PersonModel.fromJson(String source) =>
  //     PersonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonModel(id: $id, user: $user, isMale: $isMale, name: $name, nameWords: $nameWords, alias: $alias, mother: $mother, motherWords: $motherWords, note: $note, history: $history, photo: $photo, cpf: $cpf, birthday: $birthday, laws: $laws, images: $images, isArchived: $isArchived, isDeleted: $isDeleted, isPublic: $isPublic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonModel &&
        other.id == id &&
        other.user == user &&
        other.isMale == isMale &&
        other.name == name &&
        listEquals(other.nameWords, nameWords) &&
        listEquals(other.alias, alias) &&
        other.mother == mother &&
        listEquals(other.motherWords, motherWords) &&
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
        nameWords.hashCode ^
        alias.hashCode ^
        mother.hashCode ^
        motherWords.hashCode ^
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
      PersonModel.fromMap(json.decode(source));
}
