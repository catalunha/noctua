import 'package:noctua/app/data/b4a/entity/user_profile_entity.dart';
import 'package:noctua/app/domain/models/user_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserEntity {
  static const String className = 'User';

  UserModel fromParse(ParseUser parseUser) {
    return UserModel(
      id: parseUser.objectId!,
      email: parseUser.username!,
      profile: parseUser.get('profile') != null
          ? UserProfileEntity().fromParse(parseUser.get('profile'))
          : null,
    );
  }
}
