import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonImageEntity {
  static const String className = 'PersonImage';
  PersonImageModel fromParse(ParseObject parseObject) {
    print('PersonImageEntity: ${parseObject.objectId}');

    PersonImageModel model = PersonImageModel(
      id: parseObject.objectId!,
      photo: parseObject.get('photo')?.get('url'),
      note: parseObject.get<String>('note'),
    );
    return model;
  }

  Future<ParseObject> toParse(PersonImageModel model) async {
    final parseObject = ParseObject(PersonImageEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    parseObject.set('note', model.note);
    return parseObject;
  }
}
