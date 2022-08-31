import 'package:noctua/app/data/repositories/person_repository.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/usecases/person/person_filter.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';

class PersonUseCaseImpl implements PersonUseCase {
  final PersonRepository _repository;
  PersonUseCaseImpl({
    required PersonRepository repository,
  }) : _repository = repository;

  @override
  // Future<void> delete(String id) async => await _repository.delete(id);

  @override
  Future<List<PersonModel>> list(PersonFilter personFilter) async =>
      await _repository.list(personFilter);

  // @override
  // Future<void> isArchive(String id, bool mode) async =>
  //     await _repository.isArchive(id, mode);

  // @override
  // Future<PersonModel?> read(String id) async => await _repository.read(id);

  @override
  Future<String> addEdit(PersonModel model) async =>
      await _repository.addEdit(model);
  @override
  Future<bool> updateRelation(PersonModel model) async =>
      await _repository.updateRelation(model);
  // @override
  // Future<String> update(PersonModel model) async =>
  //     await _repository.update(model);
}
