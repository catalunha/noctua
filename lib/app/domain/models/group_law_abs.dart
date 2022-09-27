abstract class GroupLawAbs {
  final String? id;
  final String name;
  final String? description;
  final bool? isDeleted;
  GroupLawAbs({
    this.id,
    required this.name,
    this.description,
    this.isDeleted,
  });

  @override
  String toString() {
    return 'GroupLawAbs(id: $id, name: $name, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupLawAbs &&
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
