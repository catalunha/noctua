import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/entity/group_entity.dart';
import 'package:noctua/app/data/b4a/entity/law_entity.dart';
import 'package:noctua/app/data/b4a/entity/person_entity.dart';
import 'package:noctua/app/data/b4a/entity/person_image_entity.dart';
import 'package:noctua/app/data/b4a/person/person_repository_exception.dart';
import 'package:noctua/app/data/repositories/person_repository.dart';
import 'package:noctua/app/domain/models/group_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonRepositoryB4a extends GetxService implements PersonRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    // QueryBuilder<ParseObject> query =
    //     QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));
    final user = await ParseUser.currentUser() as ParseUser;
    query.whereEqualTo('user', user);
    query.whereEqualTo('isDeleted', false);
    query.orderByDescending('updatedAt');

    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);
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
  Future<List<PersonModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    // QueryBuilder<ParseObject> query;
    // if (queryType == GetQueryFilterPerson.archived) {
    // query = await getQueryArchived();
    // } else {
    QueryBuilder<ParseObject> queryFinal = await getQueryAll(query, pagination);
    // }

    final ParseResponse response = await queryFinal.query();
    List<PersonModel> listTemp = <PersonModel>[];
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        //print((element as ParseObject).objectId);
        listTemp.add(PersonEntity().fromParse(element));
      }
      return listTemp;
    } else {
      //print('Sem Persons...');
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

  // @override
  // Future<bool> updateRelation(PersonModel model) async {
  //   //print('updateRelation images: ${model.images}');
  //   //print('updateRelation laws: ${model.laws}');
  //   final parseObject = PersonEntity().toParseAddRelation(model);
  //   if (parseObject != null) {
  //     await parseObject.save();
  //   }
  //   final parseObject2 = PersonEntity().toParseRemoveRelation(model);
  //   if (parseObject2 != null) {
  //     await parseObject2.save();
  //   }
  //   return true;
  // }

  @override
  Future<List<PersonImageModel>> readRelationImages(String personId) async {
    //+++ get images
    List<PersonImageModel> images = [];
    QueryBuilder<ParseObject> queryImages =
        QueryBuilder<ParseObject>(ParseObject(PersonImageEntity.className));
    queryImages.whereRelatedTo('images', 'Person', personId);
    queryImages.includeObject(['person', 'person.user', 'person.user.profile']);
    final ParseResponse responseImages = await queryImages.query();
    if (responseImages.success && responseImages.results != null) {
      images = [
        ...responseImages.results!
            .map<PersonImageModel>(
                (e) => PersonImageEntity().fromParse(e as ParseObject))
            .toList()
      ]; // images.addAll(responseImages.results!
      //     .map<PersonImageModel>(
      //         (e) => PersonImageEntity().fromParse(e as ParseObject))
      //     .toList());
    }
    //--- get images
    return images;
  }

  @override
  Future<List<LawModel>> readRelationLaws(String personId) async {
    //+++ get laws
    // I/flutter (11952):  https://parseapi.back4app.com/classes/Law?where={"$relatedTo":{"object":{"__type":"Pointer","className":"Person","objectId":"jBorq8Ctgp"},"key":"laws"}}
    List<LawModel> laws = [];
    QueryBuilder<ParseObject> queryLaws =
        QueryBuilder<ParseObject>(ParseObject(LawEntity.className));
    queryLaws.whereRelatedTo('laws', 'Person', personId);
    final ParseResponse responseLaws = await queryLaws.query();
    if (responseLaws.success && responseLaws.results != null) {
      laws = [
        ...responseLaws.results!
            .map<LawModel>((e) => LawEntity().fromParse(e as ParseObject))
            .toList()
      ];
      // laws.addAll(responseLaws.results!
      //     .map<LawModel>((e) => LawEntity().fromParse(e as ParseObject))
      //     .toList());
    }
    //--- get laws
    return laws;
  }

  @override
  Future<List<GroupModel>> readRelationGroups(String personId) async {
    List<GroupModel> list = [];
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(GroupEntity.className));
    query.whereRelatedTo('groups', 'Person', personId);
    final ParseResponse response = await query.query();
    if (response.success && response.results != null) {
      list = [
        ...response.results!
            .map<GroupModel>((e) => GroupEntity().fromParse(e as ParseObject))
            .toList()
      ];
    }
    return list;
  }

  @override
  Future<void> updateRelationImages(
      String personId, List<PersonImageModel> modelList) async {
    final parseObject = PersonEntity().toParseUpdateRelationImages(
        personId: personId, modelList: modelList, add: true);
    if (parseObject != null) {
      await parseObject.save();
    }
    final parseObject2 = PersonEntity().toParseUpdateRelationImages(
        personId: personId, modelList: modelList, add: false);
    if (parseObject2 != null) {
      await parseObject2.save();
    }
  }

  @override
  Future<void> updateRelationLaws(
      String personId, List<String> addIds, List<String> removeIds) async {
    if (addIds.isNotEmpty) {
      final parseObject =
          PersonEntity().toParseAddIdsLaws(personId: personId, addIds: addIds);
      await parseObject.save();
    }

    if (removeIds.isNotEmpty) {
      final parseObject = PersonEntity()
          .toParseRemoveIdsLaws(personId: personId, removeIds: removeIds);
      await parseObject.save();
    }
  }

  @override
  Future<void> updateRelationGroups(
      String personId, List<String> addIds, List<String> removeIds) async {
    if (addIds.isNotEmpty) {
      final parseObject = PersonEntity()
          .toParseAddIdsGroups(personId: personId, addIds: addIds);
      await parseObject.save();
    }

    if (removeIds.isNotEmpty) {
      final parseObject = PersonEntity()
          .toParseRemoveIdsGroups(personId: personId, removeIds: removeIds);
      await parseObject.save();
    }
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

  @override
  Future<PersonModel?> read(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));
    query.whereEqualTo('objectId', id);
    query.includeObject(['user', 'user.profile']);
    query.first();
    final ParseResponse response = await query.query();
    PersonModel? temp;
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        // //print((element as ParseObject).objectId);
        temp = PersonEntity().fromParse(element);
      }
      // return listTemp;
    } else {
      //print('nao encontrei esta Person...');
      // return [];
    }
    return temp;
  }

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
