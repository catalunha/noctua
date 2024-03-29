import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/entity/operation_entity.dart';
import 'package:noctua/app/data/b4a/entity/person_entity.dart';
import 'package:noctua/app/data/b4a/entity/user_entity.dart';
import 'package:noctua/app/data/b4a/person/person_repository_exception.dart';
import 'package:noctua/app/data/repositories/operation_repository.dart';
import 'package:noctua/app/domain/models/operation_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class OperationRepositoryB4a extends GetxService
    implements OperationRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    final user = await ParseUser.currentUser() as ParseUser;
    QueryBuilder<ParseObject> queryOrganizer =
        QueryBuilder<ParseObject>(ParseObject(OperationEntity.className));
    queryOrganizer.whereEqualTo('organizer', user);
    queryOrganizer.whereEqualTo('isDeleted', false);
    // includeObject does not come in this query
    QueryBuilder<ParseObject> queryOperators =
        QueryBuilder<ParseObject>(ParseObject(OperationEntity.className));

    queryOperators.whereEqualTo('operators', user);
    queryOperators.whereEqualTo('isDeleted', false);
    // includeObject does not come in this query
    QueryBuilder<ParseObject> mainQuery = QueryBuilder.or(
      ParseObject(OperationEntity.className),
      [queryOperators, queryOrganizer],
    );
    mainQuery.orderByDescending('updatedAt');
    mainQuery.includeObject(['organizer', 'organizer.profile']);
    return mainQuery;
  }

/*
class OperationRepositoryB4a extends GetxService
    implements OperationRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(OperationEntity.className));
    final user = await ParseUser.currentUser() as ParseUser;
    // query.whereEqualTo('organizer', user);
    query.whereEqualTo('isDeleted', false);
    // query.whereEqualTo(
    //     'operators', ParseObject('_User')..objectId = 'b0RtxBWHZ4');
    query.whereEqualTo('operators', user);
    query.includeObject(['organizer', 'organizer.profile']);

    return query;
  }
*/

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
  Future<List<OperationModel>> list() async {
    QueryBuilder<ParseObject> query;
    // if (queryType == GetQueryFilterPerson.archived) {
    // query = await getQueryArchived();
    // } else {
    query = await getQueryAll();
    // }
    print('-*-*-*');
    final ParseResponse response = await query.query();
    print('-*-*-*');
    List<OperationModel> listTemp = <OperationModel>[];
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        //print((element as ParseObject).objectId);
        listTemp.add(OperationEntity().fromParse(element));
      }
      return listTemp;
    } else {
      print('Sem Operations...');
      return [];
    }
  }

  @override
  Future<String> addEdit(OperationModel model) async {
    final parseObject = await OperationEntity().toParse(model);
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
  Future<List<UserModel>> readRelationOperators(String operationId) async {
    //+++ get images
    List<UserModel> users = [];
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserEntity.className));
    query.whereRelatedTo('operators', 'Operation', operationId);
    query.includeObject(['profile']);
    final ParseResponse response = await query.query();
    if (response.success && response.results != null) {
      users = [
        ...response.results!
            .map<UserModel>((e) => UserEntity().fromParse(e))
            .toList()
      ];
    }
    //--- get users
    return users;
  }

  @override
  Future<List<PersonModel>> readRelationInvolveds(String operationId) async {
    //+++ get personList
    List<PersonModel> personList = [];
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));
    query.whereRelatedTo('involveds', 'Operation', operationId);
    query.includeObject(['user', 'user.profile']);
    final ParseResponse response = await query.query();
    if (response.success && response.results != null) {
      personList = [
        ...response.results!
            .map<PersonModel>((e) => PersonEntity().fromParse(e))
            .toList()
      ];
    }
    //--- get personList
    return personList;
  }

  // @override
  // Future<void> updateRelationOperators(
  //     String personId, List<UserModel> modelList) async {
  //   final parseObject = OperationEntity().toParseUpdateRelationOperators(
  //       personId: personId, modelList: modelList, add: true);
  //   if (parseObject != null) {
  //     await parseObject.save();
  //   }
  //   final parseObject2 = OperationEntity().toParseUpdateRelationOperators(
  //       personId: personId, modelList: modelList, add: false);
  //   if (parseObject2 != null) {
  //     await parseObject2.save();
  //   }
  // }
  @override
  Future<void> updateRelationOperators(
      String objectId, List<String> modelIdList, bool add) async {
    final parseObject = OperationEntity().toParseUpdateRelationOperators(
        objectId: objectId, modelIdList: modelIdList, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }

  @override
  Future<void> updateRelationInvolveds(
      String objectId, List<String> modelIdList, bool add) async {
    final parseObject = OperationEntity().toParseUpdateRelationInvolveds(
        objectId: objectId, modelIdList: modelIdList, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }
  // @override
  // Future<void> updateRelationInvolved(
  //     String personId, List<PersonModel> modelList) async {
  //   final parseObject = OperationEntity().toParseUpdateRelationInvolveds(
  //       personId: personId, modelList: modelList, add: true);

  //   if (parseObject != null) {
  //     await parseObject.save();
  //   }
  //   final parseObject2 = OperationEntity().toParseUpdateRelationInvolveds(
  //       personId: personId, modelList: modelList, add: false);
  //   if (parseObject2 != null) {
  //     await parseObject2.save();
  //   }
  // }

  @override
  Future<void> delete(String id) async {
    var parseObject = ParseObject(OperationEntity.className)..objectId = id;
    await parseObject.delete();
  }

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
  //       // //print((element as ParseObject).objectId);
  //       temp = await PersonEntity().fromParse(element);
  //     }
  //     // return listTemp;
  //   } else {
  //     //print('nao encontrei esta Person...');
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
  //       //print((element as ParseObject).objectId);
  //       listTemp.add(PersonEntity().fromParse(element));
  //     }
  //     return listTemp;
  //   } else {
  //     //print('Sem Persons this person $personId...');
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
