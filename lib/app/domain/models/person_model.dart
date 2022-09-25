// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:noctua/app/domain/models/group_model.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';

class PersonModel {
  final String? id;
  final UserModel user;
  final bool isFemale;
  final String? name;
  final List<String>? alias;
  final String? mother;
  final String? photo;
  final String? mark;
  final String? history;
  final String? cpf;
  final DateTime? birthday;
  final DateTime? contactVisual;
  final List<LawModel>? laws;
  final List<GroupModel>? groups;
  final List<PersonImageModel>? images;

  final bool isArchived;
  final bool isDeleted;
  final bool isPublic;

  List<int>? photoByte;
  bool? isSelected;

  static List<String>? onTextWords(String text) {
    List<String>? textWords =
        text.split(' ').map((e) => e.trim().toLowerCase()).toList();
    return textWords;
  }

  static List<String>? onTextSplit(String text) {
    List<String>? aliasTemp =
        text.split(',').map((e) => e.trim().toLowerCase()).toList();
    aliasTemp.removeWhere((e) => e.isEmpty);
    return aliasTemp;
  }

  PersonModel({
    this.id,
    required this.user,
    this.isFemale = false,
    this.name,
    this.alias,
    this.mother,
    this.photo,
    this.mark,
    this.history,
    this.cpf,
    this.birthday,
    this.contactVisual,
    this.laws,
    this.images,
    this.groups,
    this.isArchived = false,
    this.isDeleted = false,
    this.isPublic = false,
  });

  PersonModel copyWith({
    String? id,
    UserModel? user,
    bool? isFemale,
    String? name,
    List<String>? alias,
    String? mother,
    String? photo,
    String? mark,
    String? history,
    String? cpf,
    DateTime? birthday,
    DateTime? contactVisual,
    List<LawModel>? laws,
    List<PersonImageModel>? images,
    List<GroupModel>? groups,
    bool? isArchived,
    bool? isDeleted,
    bool? isPublic,
    List<int>? photoByte,
  }) {
    return PersonModel(
      id: id ?? this.id,
      user: user ?? this.user,
      isFemale: isFemale ?? this.isFemale,
      name: name ?? this.name,
      alias: alias ?? this.alias,
      mother: mother ?? this.mother,
      photo: photo ?? this.photo,
      mark: mark ?? this.mark,
      history: history ?? this.history,
      cpf: cpf ?? this.cpf,
      birthday: birthday ?? this.birthday,
      contactVisual: contactVisual ?? this.contactVisual,
      laws: laws ?? this.laws,
      images: images ?? this.images,
      groups: groups ?? groups,
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
    result.addAll({'isFemale': isFemale});
    if (name != null) {
      result.addAll({'name': name});
    }
    if (alias != null) {
      result.addAll({'alias': alias});
    }
    if (mother != null) {
      result.addAll({'mother': mother});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
    }
    if (mark != null) {
      result.addAll({'mark': mark});
    }
    if (history != null) {
      result.addAll({'history': history});
    }
    if (cpf != null) {
      result.addAll({'cpf': cpf});
    }
    if (birthday != null) {
      result.addAll({'birthday': birthday!.millisecondsSinceEpoch});
    }
    if (contactVisual != null) {
      result.addAll({'contactVisual': contactVisual!.millisecondsSinceEpoch});
    }
    if (laws != null) {
      result.addAll({'laws': laws!.map((x) => x.toMap()).toList()});
    }
    if (images != null) {
      result.addAll({'images': images!.map((x) => x.toMap()).toList()});
    }
    if (groups != null) {
      result.addAll({'group': groups!.map((x) => x.toMap()).toList()});
    }
    result.addAll({'isArchived': isArchived});
    result.addAll({'isDeleted': isDeleted});
    result.addAll({'isPublic': isPublic});
    if (photoByte != null) {
      result.addAll({'photoByte': photoByte});
    }

    return result;
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      id: map['id'],
      user: UserModel.fromMap(map['user']),
      isFemale: map['isFemale'] ?? false,
      name: map['name'],
      alias: List<String>.from(map['alias']),
      mother: map['mother'],
      photo: map['photo'],
      mark: map['mark'],
      history: map['history'],
      cpf: map['cpf'],
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'])
          : null,
      contactVisual: map['contactVisual'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['contactVisual'])
          : null,
      laws: map['laws'] != null
          ? List<LawModel>.from(map['laws']?.map((x) => LawModel.fromMap(x)))
          : null,
      images: map['images'] != null
          ? List<PersonImageModel>.from(
              map['images']?.map((x) => PersonImageModel.fromMap(x)))
          : null,
      groups: map['group'] != null
          ? List<GroupModel>.from(
              map['group']?.map((x) => GroupModel.fromMap(x)))
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
    return 'PersonModel(id: $id, user: $user, isFemale: $isFemale, name: $name, alias: $alias, mother: $mother, photo: $photo, mark: $mark, history: $history, cpf: $cpf, birthday: $birthday, contactVisual: $contactVisual, laws: $laws, images: $images, group: $groups, isArchived: $isArchived, isDeleted: $isDeleted, isPublic: $isPublic, photoByte: $photoByte)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonModel &&
        other.id == id &&
        other.user == user &&
        other.isFemale == isFemale &&
        other.name == name &&
        listEquals(other.alias, alias) &&
        other.mother == mother &&
        other.photo == photo &&
        other.mark == mark &&
        other.history == history &&
        other.cpf == cpf &&
        other.birthday == birthday &&
        other.contactVisual == contactVisual &&
        listEquals(other.laws, laws) &&
        listEquals(other.images, images) &&
        listEquals(other.groups, groups) &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted &&
        other.isPublic == isPublic &&
        listEquals(other.photoByte, photoByte);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        isFemale.hashCode ^
        name.hashCode ^
        alias.hashCode ^
        mother.hashCode ^
        photo.hashCode ^
        mark.hashCode ^
        history.hashCode ^
        cpf.hashCode ^
        birthday.hashCode ^
        contactVisual.hashCode ^
        laws.hashCode ^
        images.hashCode ^
        groups.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode ^
        isPublic.hashCode ^
        photoByte.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) =>
      PersonModel.fromMap(json.decode(source));
}
