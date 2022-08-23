import 'package:noctua/app/data/b4a/entity/user_entity.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonEntity {
  static const String className = 'Person';
  PersonModel fromParse(ParseObject parseObject) {
    print('PersonEntity: ${parseObject.objectId}');

    PersonModel model = PersonModel(
      id: parseObject.objectId!,
      user: UserEntity().fromParse(parseObject.get('user') as ParseUser),
      name: parseObject.get<String>('name'),
      isMale: parseObject.get<bool>('isMale') ?? true,
      alias: parseObject.get<List<dynamic>>('alias') != null
          ? parseObject
              .get<List<dynamic>>('alias')!
              .map((e) => e.toString())
              .toList()
          : [],
      history: parseObject.get<String>('history'),
    );
    return model;
  }

  Future<ParseObject> toParse(PersonModel model) async {
    final parseObject = ParseObject(PersonEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    var currentUser = await ParseUser.currentUser() as ParseUser?;
    parseObject.set('user', currentUser);
    parseObject.set('name', model.name);
    parseObject.set('isMale', model.isMale);
    parseObject.set('alias', model.alias);
    parseObject.set('history', model.history);

    return parseObject;
  }
}
