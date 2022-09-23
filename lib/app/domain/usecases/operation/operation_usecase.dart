import 'package:noctua/app/domain/models/operation_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';

abstract class OperationUsecase {
  Future<List<OperationModel>> list();
  // Future<OperationModel?> read(String id);
  Future<String> addEdit(OperationModel model);
  Future<List<UserModel>> readRelationOperators(String operationId);
  Future<void> updateRelationOperators(
      String objectId, List<String> modelIdList, bool add);
  Future<List<PersonModel>> readRelationInvolveds(String operationId);
  Future<void> updateRelationInvolveds(
      String personId, List<String> modelIdList, bool add);
  Future<void> delete(String id);
}
