import 'package:noctua/app/domain/models/operation_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';

abstract class OperationUsecase {
  Future<List<OperationModel>> list();
  // Future<OperationModel?> read(String id);
  Future<String> addEdit(OperationModel model);
  Future<List<UserModel>> readRelationOperators(String userId);
  Future<void> updateRelationOperators(
      String objectId, List<String> modelIdList, bool add);
  Future<List<PersonModel>> readRelationInvolved(String personId);
  Future<void> updateRelationInvolved(
      String personId, List<PersonModel> personList);
  Future<void> delete(String id);
}
