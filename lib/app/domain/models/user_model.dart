import 'dart:convert';

import 'package:noctua/app/domain/models/user_profile_model.dart';

class UserModel {
  final String id;
  final String email;
  UserProfileModel? profile;
  bool? isSelected;
  UserModel({
    required this.id,
    required this.email,
    this.profile,
  });

  UserModel copyWith({
    String? id,
    String? email,
    UserProfileModel? profile,
    bool? isSelected,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'email': email});
    if (profile != null) {
      result.addAll({'profile': profile!.toMap()});
    }
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      profile: map['profile'] != null
          ? UserProfileModel.fromMap(map['profile'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, profile: $profile, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.profile == profile &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        profile.hashCode ^
        isSelected.hashCode;
  }
}
