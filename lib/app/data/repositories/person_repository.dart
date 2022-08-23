import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/usecases/person/person_filter.dart';

abstract class PersonRepository {
  Future<List<PersonModel>> list(PersonFilter personFilter);
  Future<String> add(PersonModel model);
  Future<String> update(PersonModel model);
  Future<void> delete(String id);
  Future<PersonModel?> read(String id);
}
