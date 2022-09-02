import 'package:noctua/app/data/b4a/entity/person_entity.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonImageEntity {
  static const String className = 'PersonImage';
  PersonImageModel fromParse(ParseObject parseObject) {
    //print('PersonImageEntity: ${parseObject.objectId}');

    PersonImageModel model = PersonImageModel(
      id: parseObject.objectId!,
      photo: parseObject.get('photo')?.get('url'),
      person: PersonEntity().fromParse(parseObject.get('person')),
    );
    return model;
  }

  Future<ParseObject> toParse(PersonImageModel model) async {
    final parseObject = ParseObject(PersonImageEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    parseObject.set('person',
        (ParseObject('Person')..objectId = model.person.id).toPointer());
    return parseObject;
  }
}
