import 'package:noctua/app/domain/models/group_model.dart';

abstract class GroupRepository {
  Future<List<GroupModel>> list();
}
