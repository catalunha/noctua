import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/entity/group_entity.dart';
import 'package:noctua/app/data/repositories/group_repository.dart';
import 'package:noctua/app/domain/models/group_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class GroupRepositoryB4a extends GetxService implements GroupRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(GroupEntity.className));
    query.whereEqualTo('isDeleted', false);
    query.orderByAscending('name');
    return query;
  }

  @override
  Future<List<GroupModel>> list() async {
    QueryBuilder<ParseObject> query;
    query = await getQueryAll();

    final ParseResponse response = await query.query();
    List<GroupModel> listTemp = <GroupModel>[];
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        //print((element as ParseObject).objectId);
        listTemp.add(GroupEntity().fromParse(element));
      }
      return listTemp;
    } else {
      //print('Sem Groups...');
      return [];
    }
  }
}
