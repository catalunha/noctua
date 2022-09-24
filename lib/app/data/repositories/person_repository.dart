import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/utils/pagination.dart';

abstract class PersonRepository {
  Future<List<PersonModel>> list(Pagination pagination);
  Future<PersonModel?> read(String id);
  Future<String> addEdit(PersonModel model);
  Future<List<LawModel>> readRelationLaws(String personId);
  Future<void> updateRelationLaws(String personId, List<LawModel> modelList);
  Future<List<PersonImageModel>> readRelationImages(String personId);
  Future<void> updateRelationImages(
      String personId, List<PersonImageModel> modelList);
  // Future<void> delete(String id);
  // Future<bool> updateRelation(PersonModel model);
}
