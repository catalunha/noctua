import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/usecases/person/person_filter.dart';

abstract class PersonUseCase {
  Future<List<PersonModel>> list(PersonFilter personFilter);
  Future<String> addEdit(PersonModel model);
  Future<bool> updateRelation(PersonModel model);
  // Future<PersonModel?> read(String id);
}
