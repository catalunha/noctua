import 'package:noctua/app/domain/models/group_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class GroupEntity {
  static const String className = 'Group';
  GroupModel fromParse(ParseObject parseObject) {
    //print('GroupEntity: ${parseObject.objectId}');

    GroupModel model = GroupModel(
      id: parseObject.objectId!,
      name: parseObject.get<String>('name') ?? "...",
      description: parseObject.get<String>('description'),
    );
    return model;
  }

  Future<ParseObject> toParse(GroupModel model) async {
    final parseObject = ParseObject(GroupEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    parseObject.set('name', model.name);
    parseObject.set('description', model.description);
    return parseObject;
  }
}
