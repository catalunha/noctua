// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PersonImageModel {
  final String? id;
  final String? photo;
  final String? note;
  final bool? isDeleted;
  PersonImageModel({
    this.id,
    this.photo,
    this.note,
    this.isDeleted,
  });

  PersonImageModel copyWith({
    String? id,
    String? photo,
    String? note,
    bool? isDeleted,
  }) {
    return PersonImageModel(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      note: note ?? this.note,
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
    if (note != null) {
      result.addAll({'note': note});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory PersonImageModel.fromMap(Map<String, dynamic> map) {
    return PersonImageModel(
      id: map['id'],
      photo: map['photo'],
      note: map['note'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonImageModel.fromJson(String source) =>
      PersonImageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonImageModel(id: $id, photo: $photo, note: $note, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonImageModel &&
        other.id == id &&
        other.photo == photo &&
        other.note == note &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^ photo.hashCode ^ note.hashCode ^ isDeleted.hashCode;
  }
}
