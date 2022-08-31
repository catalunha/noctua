import 'package:noctua/app/domain/models/law_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LawEntity {
  static const String className = 'Law';
  LawModel fromParse(ParseObject parseObject) {
    //print('LawEntity: ${parseObject.objectId}');

    LawModel model = LawModel(
      id: parseObject.objectId!,
      name: parseObject.get<String>('name') ?? "...",
      note: parseObject.get<String>('note'),
    );
    return model;
  }

  Future<ParseObject> toParse(LawModel model) async {
    final parseObject = ParseObject(LawEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    parseObject.set('name', model.name);
    parseObject.set('note', model.note);
    return parseObject;
  }
}
