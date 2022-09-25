import 'package:noctua/app/domain/models/group_model.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class PersonUseCase {
  Future<List<PersonModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination);
  Future<String> addEdit(PersonModel model);
  // Future<bool> updateRelation(PersonModel model);
  Future<List<GroupModel>> readRelationGroups(String personId);
  Future<void> updateRelationGroups(
      String personId, List<String> addIds, List<String> removeIds);
  Future<List<LawModel>> readRelationLaws(String personId);
  Future<void> updateRelationLaws(
      String personId, List<String> addIds, List<String> removeIds);
  Future<List<PersonImageModel>> readRelationImages(String personId);
  Future<void> updateRelationImages(
      String personId, List<PersonImageModel> modelList);
  Future<PersonModel?> read(String id);
}
