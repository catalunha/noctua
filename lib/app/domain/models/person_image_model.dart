// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PersonImageModel {
  final String? id;
  final String? photo;
  final String? note;
  PersonImageModel({
    this.id,
    this.photo,
    this.note,
  });

  PersonImageModel copyWith({
    String? id,
    String? photo,
    String? note,
  }) {
    return PersonImageModel(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'photo': photo,
      'note': note,
    };
  }

  factory PersonImageModel.fromMap(Map<String, dynamic> map) {
    return PersonImageModel(
      id: map['id'] != null ? map['id'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonImageModel.fromJson(String source) =>
      PersonImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PersonImageModel(id: $id, photo: $photo, note: $note)';

  @override
  bool operator ==(covariant PersonImageModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.photo == photo && other.note == note;
  }

  @override
  int get hashCode => id.hashCode ^ photo.hashCode ^ note.hashCode;
}
