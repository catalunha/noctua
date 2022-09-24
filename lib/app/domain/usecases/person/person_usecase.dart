import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/utils/pagination.dart';

abstract class PersonUseCase {
  Future<List<PersonModel>> list(Pagination pagination);
  Future<String> addEdit(PersonModel model);
  // Future<bool> updateRelation(PersonModel model);
  Future<List<LawModel>> readRelationLaws(String personId);
  Future<void> updateRelationLaws(String personId, List<LawModel> modelList);
  Future<List<PersonImageModel>> readRelationImages(String personId);
  Future<void> updateRelationImages(
      String personId, List<PersonImageModel> modelList);
  Future<PersonModel?> read(String id);
}
