import 'package:noctua/app/data/repositories/person_repository.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
import 'package:noctua/app/domain/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonUseCaseImpl implements PersonUseCase {
  final PersonRepository _repository;
  PersonUseCaseImpl({
    required PersonRepository repository,
  }) : _repository = repository;

  @override
  // Future<void> delete(String id) async => await _repository.delete(id);

  @override
  Future<List<PersonModel>> list(
          QueryBuilder<ParseObject> query, Pagination pagination) async =>
      await _repository.list(query, pagination);

  // @override
  // Future<void> isArchive(String id, bool mode) async =>
  //     await _repository.isArchive(id, mode);

  @override
  Future<PersonModel?> read(String id) async => await _repository.read(id);

  @override
  Future<String> addEdit(PersonModel model) async =>
      await _repository.addEdit(model);

  @override
  Future<List<PersonImageModel>> readRelationImages(String personId) async =>
      await _repository.readRelationImages(personId);
  @override
  Future<List<LawModel>> readRelationLaws(String personId) async =>
      await _repository.readRelationLaws(personId);

  @override
  Future<void> updateRelationImages(
          String personId, List<PersonImageModel> modelList) async =>
      await _repository.updateRelationImages(personId, modelList);

  @override
  Future<void> updateRelationLaws(
          String personId, List<LawModel> modelList) async =>
      await _repository.updateRelationLaws(personId, modelList);

  // @override
  // Future<bool> updateRelation(PersonModel model) async =>
  //     await _repository.updateRelation(model);
  // @override
  // Future<String> update(PersonModel model) async =>
  //     await _repository.update(model);
}
