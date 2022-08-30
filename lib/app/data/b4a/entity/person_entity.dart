import 'package:noctua/app/data/b4a/entity/law_entity.dart';
import 'package:noctua/app/data/b4a/entity/person_image_entity.dart';
import 'package:noctua/app/data/b4a/entity/user_entity.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonEntity {
  static const String className = 'Person';
  Future<PersonModel> fromParse(ParseObject parseObject) async {
    print('PersonEntity: ${parseObject.objectId}');
    //+++ get laws
    final List<LawModel> laws = [];
    QueryBuilder<ParseObject> queryLaws =
        QueryBuilder<ParseObject>(ParseObject(LawEntity.className));
    queryLaws.whereRelatedTo('laws', 'Person', parseObject.objectId!);
    final ParseResponse responseLaws = await queryLaws.query();
    if (responseLaws.success && responseLaws.results != null) {
      laws.addAll(responseLaws.results!
          .map<LawModel>((e) => LawEntity().fromParse(e as ParseObject))
          .toList());
    }
    //--- get laws
    //+++ get images
    final List<PersonImageModel> images = [];
    QueryBuilder<ParseObject> queryImages =
        QueryBuilder<ParseObject>(ParseObject(PersonImageEntity.className));
    queryImages.whereRelatedTo('images', 'Person', parseObject.objectId!);
    final ParseResponse responseImages = await queryImages.query();
    if (responseImages.success && responseImages.results != null) {
      images.addAll(responseImages.results!
          .map<PersonImageModel>(
              (e) => PersonImageEntity().fromParse(e as ParseObject))
          .toList());
    }
    //--- get images
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
      note: parseObject.get<String>('note'),
      history: parseObject.get<String>('history'),
      mother: parseObject.get<String>('mother'),
      cpf: parseObject.get<String>('cpf'),
      isArchived: parseObject.get<bool>('isArchived') ?? false,
      isPublic: parseObject.get<bool>('isPublic') ?? false,
      isDeleted: parseObject.get<bool>('isDeleted') ?? false,
      photo: parseObject.get('photo')?.get('url'),
      birthday: parseObject.get('birthday'),
      laws: laws,
      images: images,
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
    parseObject.set('note', model.note);
    parseObject.set('mother', model.mother);
    parseObject.set('isArchived', model.isArchived);
    parseObject.set('isDeleted', model.isDeleted);
    parseObject.set('isPublic', model.isPublic);
    parseObject.set('cpf', model.cpf);
    parseObject.set('birthday', model.birthday);
    if (model.laws == null) {
      parseObject.unset('laws');
    } else {
      parseObject.addRelation(
          'laws',
          model.laws!
              .map((law) => ParseObject(LawEntity.className)..objectId = law.id)
              .toList());
    }
    if (model.images == null) {
      parseObject.unset('images');
    } else {
      parseObject.addRelation(
          'images',
          model.images!
              .map((images) => ParseObject(PersonImageEntity.className)
                ..objectId = images.id)
              .toList());
    }
    return parseObject;
  }
}
