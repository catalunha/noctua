import 'package:noctua/app/data/b4a/entity/law_entity.dart';
import 'package:noctua/app/data/b4a/entity/person_image_entity.dart';
import 'package:noctua/app/data/b4a/entity/user_entity.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonEntity {
  static const String className = 'Person';
  PersonModel fromParse(ParseObject parseObject) {
    //print('PersonEntity: ${parseObject.objectId}');
    //+++ get laws
    List<LawModel> laws = [];
    // QueryBuilder<ParseObject> queryLaws =
    //     QueryBuilder<ParseObject>(ParseObject(LawEntity.className));
    // queryLaws.whereRelatedTo('laws', 'Person', parseObject.objectId!);
    // final ParseResponse responseLaws = await queryLaws.query();
    // if (responseLaws.success && responseLaws.results != null) {
    //   laws = [
    //     ...responseLaws.results!
    //         .map<LawModel>((e) => LawEntity().fromParse(e as ParseObject))
    //         .toList()
    //   ];
    //   // laws.addAll(responseLaws.results!
    //   //     .map<LawModel>((e) => LawEntity().fromParse(e as ParseObject))
    //   //     .toList());
    // }
    //--- get laws
    //+++ get images
    List<PersonImageModel> images = [];
    // QueryBuilder<ParseObject> queryImages =
    //     QueryBuilder<ParseObject>(ParseObject(PersonImageEntity.className));
    // queryImages.whereRelatedTo('images', 'Person', parseObject.objectId!);
    // final ParseResponse responseImages = await queryImages.query();
    // if (responseImages.success && responseImages.results != null) {
    //   images = [
    //     ...responseImages.results!
    //         .map<PersonImageModel>(
    //             (e) => PersonImageEntity().fromParse(e as ParseObject))
    //         .toList()
    //   ]; // images.addAll(responseImages.results!
    //   //     .map<PersonImageModel>(
    //   //         (e) => PersonImageEntity().fromParse(e as ParseObject))
    //   //     .toList());
    // }
    //--- get images
    print('parseObject: $parseObject');
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
    // if (model.laws == null) {
    //   parseObject.unset('laws');
    // } else {
    //   parseObject.addRelation(
    //       'laws',
    //       model.laws!
    //           .map((law) => ParseObject(LawEntity.className)..objectId = law.id)
    //           .toList());
    // }
    // if (model.images == null) {
    //   parseObject.unset('images');
    // } else {
    //   List<String> addImage = [];
    //   List<String> removeImage = [];

    //   for (var image in model.images!) {
    //     if (image.isDeleted) {
    //       removeImage.add(image.id!);
    //     } else {
    //       addImage.add(image.id!);
    //     }
    //   }
    //   parseObject.removeRelation(
    //       'images',
    //       removeImage
    //           .map((imageId) =>
    //               ParseObject(PersonImageEntity.className)..objectId = imageId)
    //           .toList());
    //   // parseObject.addRelation(
    //   //     'images',
    //   //     addImage
    //   //         .map((imageId) =>
    //   //             ParseObject(PersonImageEntity.className)..objectId = imageId)
    //   //         .toList());
    // }
    return parseObject;
  }

  // ParseObject? toParseAddRelation(PersonModel model) {
  //   final parseObject = ParseObject(PersonEntity.className);
  //   if (model.id != null) {
  //     parseObject.objectId = model.id;
  //   }

  //   List<String> addImage = [];
  //   if (model.images == null) {
  //     parseObject.unset('images');
  //   } else {
  //     for (var image in model.images!) {
  //       if (image.isDeleted == false) {
  //         addImage.add(image.id!);
  //       }
  //     }
  //     if (addImage.isNotEmpty) {
  //       parseObject.addRelation(
  //         'images',
  //         addImage
  //             .map((imageId) =>
  //                 ParseObject(PersonImageEntity.className)..objectId = imageId)
  //             .toList(),
  //       );
  //     }
  //   }

  //   List<String> addLaw = [];
  //   if (model.laws == null) {
  //     parseObject.unset('laws');
  //   } else {
  //     for (var law in model.laws!) {
  //       if (law.isDeleted == false) {
  //         addLaw.add(law.id!);
  //       }
  //     }

  //     if (addLaw.isNotEmpty) {
  //       parseObject.addRelation(
  //         'laws',
  //         addLaw
  //             .map(
  //                 (lawId) => ParseObject(LawEntity.className)..objectId = lawId)
  //             .toList(),
  //       );
  //     }
  //   }

  //   if (addImage.isEmpty && addLaw.isEmpty) {
  //     return null;
  //   } else {
  //     return parseObject;
  //   }
  // }

  // ParseObject? toParseRemoveRelation(PersonModel model) {
  //   final parseObject = ParseObject(PersonEntity.className);
  //   if (model.id != null) {
  //     parseObject.objectId = model.id;
  //   }

  //   List<String> removeImage = [];
  //   if (model.images == null) {
  //     parseObject.unset('images');
  //   } else {
  //     for (var image in model.images!) {
  //       if (image.isDeleted == true) {
  //         removeImage.add(image.id!);
  //       }
  //     }
  //     if (removeImage.isNotEmpty) {
  //       parseObject.removeRelation(
  //           'images',
  //           removeImage
  //               .map((imageId) => ParseObject(PersonImageEntity.className)
  //                 ..objectId = imageId)
  //               .toList());
  //     }
  //   }

  //   List<String> removeLaw = [];
  //   if (model.laws == null) {
  //     parseObject.unset('laws');
  //   } else {
  //     for (var law in model.laws!) {
  //       if (law.isDeleted == true) {
  //         removeLaw.add(law.id!);
  //       }
  //     }
  //     if (removeLaw.isNotEmpty) {
  //       parseObject.removeRelation(
  //           'laws',
  //           removeLaw
  //               .map((lawId) =>
  //                   ParseObject(LawEntity.className)..objectId = lawId)
  //               .toList());
  //     }
  //   }
  //   //print('toParseRemoveRelation laws $removeLaw');
  //   //print(parseObject.toJson());
  //   //print('=-=-');
  //   if (removeImage.isEmpty && removeLaw.isEmpty) {
  //     return null;
  //   } else {
  //     return parseObject;
  //   }
  // }

  ParseObject? toParseUpdateRelationLaws(
      {required String personId,
      required List<LawModel> modelList,
      bool add = false}) {
    final parseObject = ParseObject(PersonEntity.className);
    parseObject.objectId = personId;
    List<String> itemList = [];
    if (add) {
      if (modelList.isEmpty) {
        parseObject.unset('laws');
      } else {
        for (var element in modelList) {
          if (element.isDeleted == false) {
            itemList.add(element.id!);
          }
        }
        if (itemList.isNotEmpty) {
          parseObject.addRelation(
            'laws',
            itemList
                .map((element) =>
                    ParseObject(LawEntity.className)..objectId = element)
                .toList(),
          );
        }
      }
    } else {
      if (modelList.isEmpty) {
        parseObject.unset('laws');
      } else {
        for (var image in modelList) {
          if (image.isDeleted == true) {
            itemList.add(image.id!);
          }
        }
        if (itemList.isNotEmpty) {
          parseObject.removeRelation(
              'laws',
              itemList
                  .map((element) =>
                      ParseObject(LawEntity.className)..objectId = element)
                  .toList());
        }
      }
    }
    if (modelList.isNotEmpty && itemList.isEmpty) {
      return null;
    } else {
      return parseObject;
    }
  }

  ParseObject? toParseUpdateRelationImages(
      {required String personId,
      required List<PersonImageModel> modelList,
      bool add = false}) {
    final parseObject = ParseObject(PersonEntity.className);
    parseObject.objectId = personId;
    List<String> itemList = [];
    if (add) {
      if (modelList.isEmpty) {
        parseObject.unset('images');
      } else {
        for (var element in modelList) {
          if (element.isDeleted == false) {
            itemList.add(element.id!);
          }
        }
        if (itemList.isNotEmpty) {
          parseObject.addRelation(
            'images',
            itemList
                .map((element) => ParseObject(PersonImageEntity.className)
                  ..objectId = element)
                .toList(),
          );
        }
      }
    } else {
      if (modelList.isEmpty) {
        parseObject.unset('images');
      } else {
        for (var image in modelList) {
          if (image.isDeleted == true) {
            itemList.add(image.id!);
          }
        }
        if (itemList.isNotEmpty) {
          parseObject.removeRelation(
            'images',
            itemList
                .map((element) => ParseObject(PersonImageEntity.className)
                  ..objectId = element)
                .toList(),
          );
          for (var element in itemList) {
            var parseObject = ParseObject(PersonImageEntity.className)
              ..objectId = element;
            parseObject.set('isDeleted', true);
            parseObject.save();
          }
        }
      }
    }

    if (modelList.isNotEmpty && itemList.isEmpty) {
      return null;
    } else {
      return parseObject;
    }
  }
}
