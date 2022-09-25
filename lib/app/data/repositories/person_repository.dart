import 'package:noctua/app/domain/models/group_model.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class PersonRepository {
  Future<List<PersonModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination);
  Future<PersonModel?> read(String id);
  Future<String> addEdit(PersonModel model);
  Future<List<GroupModel>> readRelationGroups(String personId);
  Future<void> updateRelationGroups(
      String personId, List<String> addIds, List<String> removeIds);
  Future<List<LawModel>> readRelationLaws(String personId);
  Future<void> updateRelationLaws(
      String personId, List<String> addIds, List<String> removeIds);
  Future<List<PersonImageModel>> readRelationImages(String personId);
  Future<void> updateRelationImages(
      String personId, List<PersonImageModel> modelList);
  // Future<void> delete(String id);
  // Future<bool> updateRelation(PersonModel model);
}
