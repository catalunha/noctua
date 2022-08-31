import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/entity/law_entity.dart';
import 'package:noctua/app/data/repositories/law_repository.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LawRepositoryB4a extends GetxService implements LawRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(LawEntity.className));
    return query;
  }

  @override
  Future<List<LawModel>> list() async {
    QueryBuilder<ParseObject> query;
    query = await getQueryAll();

    final ParseResponse response = await query.query();
    List<LawModel> listTemp = <LawModel>[];
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        //print((element as ParseObject).objectId);
        listTemp.add(LawEntity().fromParse(element));
      }
      return listTemp;
    } else {
      //print('Sem Laws...');
      return [];
    }
  }
}
