import 'package:noctua/app/data/repositories/operation_repository.dart';
import 'package:noctua/app/domain/models/operation_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';
import 'package:noctua/app/domain/usecases/operation/operation_usecase.dart';

class OperationUseCaseImpl implements OperationUsecase {
  final OperationRepository _repository;
  OperationUseCaseImpl({
    required OperationRepository repository,
  }) : _repository = repository;

  @override
  // Future<void> delete(String id) async => await _repository.delete(id);

  @override
  Future<List<OperationModel>> list() async => await _repository.list();

  // @override
  // Future<OperationModel?> read(String id) async => await _repository.read(id);

  @override
  Future<String> addEdit(OperationModel model) async =>
      await _repository.addEdit(model);

  @override
  Future<List<UserModel>> readRelationOperators(String personId) async =>
      await _repository.readRelationOperators(personId);
  @override
  Future<List<PersonModel>> readRelationInvolved(String personId) async =>
      await _repository.readRelationInvolveds(personId);

  @override
  Future<void> updateRelationOperators(
          String objectId, List<String> modelIdList, bool add) async =>
      await _repository.updateRelationOperators(objectId, modelIdList, add);

  @override
  Future<void> updateRelationInvolved(
          String personId, List<PersonModel> modelList) async =>
      await _repository.updateRelationInvolved(personId, modelList);

  @override
  Future<void> delete(String id) async => await _repository.delete(id);
}
