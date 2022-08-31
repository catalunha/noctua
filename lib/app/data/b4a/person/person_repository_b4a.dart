import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/entity/person_entity.dart';
import 'package:noctua/app/data/b4a/person/person_repository_exception.dart';
import 'package:noctua/app/data/repositories/person_repository.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/usecases/person/person_filter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonRepositoryB4a extends GetxService implements PersonRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      PersonFilter personFilter) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));
    // final user = await ParseUser.currentUser() as ParseUser;
    // query.whereEqualTo('isMale', true);
    // query.
    query.whereEqualTo('isDeleted', false);
    query.includeObject(['user', 'user.profile']);
    return query;
  }

  // Future<QueryBuilder<ParseObject>> getQueryArchived() async {
  //   QueryBuilder<ParseObject> query =
  //       QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));
  //   final user = await ParseUser.currentUser() as ParseUser;
  //   query.whereEqualTo('user', user);
  //   query.whereEqualTo('isDeleted', false);
  //   query.whereEqualTo('isArchived', true);
  //   query.orderByAscending('folder');
  //   query.includeObject(['user', 'user.profile']);
  //   return query;
  // }

  // Future<QueryBuilder<ParseObject>> getQueryThisPerson(String personId) async {
  //   QueryBuilder<ParseObject> query =
  //       QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));
  //   // query.whereEqualTo('user', personId);
  //   query.whereEqualTo('user', ParseObject('_User')..objectId = personId);

  //   query.whereEqualTo('isPublic', true);
  //   query.orderByAscending('folder');
  //   query.includeObject(['user', 'user.profile']);
  //   return query;
  // }

  @override
  Future<List<PersonModel>> list(PersonFilter personFilter) async {
    QueryBuilder<ParseObject> query;
    // if (queryType == GetQueryFilterPerson.archived) {
    // query = await getQueryArchived();
    // } else {
    query = await getQueryAll(personFilter);
    // }

    final ParseResponse response = await query.query();
    List<PersonModel> listTemp = <PersonModel>[];
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        print((element as ParseObject).objectId);
        listTemp.add(await PersonEntity().fromParse(element));
      }
      return listTemp;
    } else {
      print('Sem Persons...');
      return [];
    }
  }

  @override
  Future<String> addEdit(PersonModel model) async {
    final parseObject = await PersonEntity().toParse(model);
    final ParseResponse parseResponse = await parseObject.save();

    if (parseResponse.success && parseResponse.results != null) {
      ParseObject userProfile = parseResponse.results!.first as ParseObject;
      return userProfile.objectId!;
    } else {
      throw PersonRepositoryException(
          code: 1, message: 'Não foi possivel cadastrar/atualizar o bem.');
    }
  }

  @override
  Future<bool> updateRelation(PersonModel model) async {
    print('updateRelation images: ${model.images}');
    final parseObject = PersonEntity().toParseAddRelation(model);
    if (parseObject != null) {
      await parseObject.save();
    }
    final parseObject2 = PersonEntity().toParseRemoveRelation(model);
    if (parseObject2 != null) {
      await parseObject2.save();
    }
    return true;
  }

  // @override
  // Future<void> delete(String id) async {
  //   var parseObject = ParseObject(PersonEntity.className)..objectId = id;
  //   await parseObject.delete();
  // }

  // @override
  // Future<void> isArchive(String id, bool mode) async {
  //   var parseObject = ParseObject(PersonEntity.className)..objectId = id;
  //   parseObject.set('isArchived', mode);
  //   await parseObject.save();
  // }

  // @override
  // Future<PersonModel?> read(String id) async {
  //   QueryBuilder<ParseObject> query =
  //       QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));
  //   query.whereEqualTo('objectId', id);
  //   query.includeObject(['user', 'user.profile']);
  //   query.first();
  //   final ParseResponse response = await query.query();
  //   PersonModel? temp;
  //   if (response.success && response.results != null) {
  //     for (var element in response.results!) {
  //       // print((element as ParseObject).objectId);
  //       temp = await PersonEntity().fromParse(element);
  //     }
  //     // return listTemp;
  //   } else {
  //     print('nao encontrei esta Person...');
  //     // return [];
  //   }
  //   return temp;
  // }

  // @override
  // Future<List<PersonModel>> listThisPerson(String personId) async {
  //   QueryBuilder<ParseObject> query;
  //   query = await getQueryThisPerson(personId);

  //   final ParseResponse response = await query.query();
  //   List<PersonModel> listTemp = <PersonModel>[];
  //   if (response.success && response.results != null) {
  //     for (var element in response.results!) {
  //       print((element as ParseObject).objectId);
  //       listTemp.add(PersonEntity().fromParse(element));
  //     }
  //     return listTemp;
  //   } else {
  //     print('Sem Persons this person $personId...');
  //     return [];
  //   }
  // }

  // @override
  // Future<String> add(PersonModel model) async {
  //   return await append(model);
  // }

  // @override
  // Future<String> update(PersonModel model) async {
  //   return await append(model);
  // }
}
