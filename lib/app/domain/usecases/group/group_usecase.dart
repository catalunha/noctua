import 'package:noctua/app/domain/models/group_model.dart';

abstract class GroupUseCase {
  Future<List<GroupModel>> list();
}
