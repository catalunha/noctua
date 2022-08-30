// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LawModel {
  final String? id;
  final String name;
  final String? note;
  LawModel({
    this.id,
    required this.name,
    this.note,
  });

  LawModel copyWith({
    String? id,
    String? name,
    String? note,
  }) {
    return LawModel(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'note': note,
    };
  }

  factory LawModel.fromMap(Map<String, dynamic> map) {
    return LawModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LawModel.fromJson(String source) =>
      LawModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Law(id: $id, name: $name, note: $note)';

  @override
  bool operator ==(covariant LawModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.note == note;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ note.hashCode;
}
