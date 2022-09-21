// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LawModel {
  final String? id;
  final String book;
  final String name;
  final String? description;
  final bool? isDeleted;
  LawModel({
    this.id,
    required this.book,
    required this.name,
    this.description,
    this.isDeleted,
  });

  LawModel copyWith({
    String? id,
    String? book,
    String? name,
    String? description,
    bool? isDeleted,
  }) {
    return LawModel(
      id: id ?? this.id,
      book: book ?? this.book,
      name: name ?? this.name,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'book': book});
    result.addAll({'name': name});
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory LawModel.fromMap(Map<String, dynamic> map) {
    return LawModel(
      id: map['id'],
      book: map['book'] ?? '',
      name: map['name'] ?? '',
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LawModel.fromJson(String source) =>
      LawModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LawModel(id: $id, book: $book, name: $name, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LawModel &&
        other.id == id &&
        other.book == book &&
        other.name == name &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        book.hashCode ^
        name.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
