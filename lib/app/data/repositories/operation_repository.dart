import 'package:noctua/app/domain/models/operation_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';

abstract class OperationRepository {
  Future<List<OperationModel>> list();
  // Future<PersonModel?> read(String id);
  Future<String> addEdit(OperationModel model);
  Future<List<UserModel>> readRelationOperators(String userId);
  Future<void> updateRelationOperators(
      String objectId, List<String> modelIdList, bool add);
  // Future<void> updateRelationOperators(String userId, List<UserModel> userList);
  Future<List<PersonModel>> readRelationInvolveds(String personId);
  Future<void> updateRelationInvolved(
      String personId, List<PersonModel> personList);
  Future<void> delete(String id);
}
