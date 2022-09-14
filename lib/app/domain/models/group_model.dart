// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GroupModel {
  final String? id;
  final String name;
  final String? description;
  final bool? isDeleted;
  GroupModel({
    this.id,
    required this.name,
    this.description,
    this.isDeleted,
  });

  GroupModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? isDeleted,
  }) {
    return GroupModel(
      id: id ?? this.id,
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
    result.addAll({'name': name});
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'],
      name: map['name'] ?? '',
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupModel(id: $id, name: $name, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
