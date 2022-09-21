import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/entity/user_entity.dart';
import 'package:noctua/app/data/b4a/user/user/user_repository_exception.dart';
import 'package:noctua/app/data/repositories/user_repository.dart';
import 'package:noctua/app/domain/models/user_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserRepositoryB4a extends GetxService implements UserRepository {
  @override
  Future<List<UserModel>> list() async {
    return [];
  }

  @override
  Future<UserModel?> readByEmail(String email) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserEntity.className));
    query.whereEqualTo('email', email);
    query.includeObject(['profile']);
    query.first();
    final ParseResponse response;
    try {
      response = await query.query();
    } catch (e) {
      throw UserRepositoryException(
          code: '123', message: 'Erro ao buscar user');
    }
    UserModel? temp;
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        print('readByEmail:');
        print((element as ParseObject).objectId);
        print(element);
        temp = UserEntity().fromParse(element);
        print(temp);
      }
      print(temp);
      return temp;
    } else {
      //print('nao encontrei este User...');
      return null;
    }
  }
}
