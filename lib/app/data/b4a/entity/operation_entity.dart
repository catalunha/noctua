import 'package:noctua/app/data/b4a/entity/person_entity.dart';
import 'package:noctua/app/data/b4a/entity/user_entity.dart';
import 'package:noctua/app/domain/models/operation_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class OperationEntity {
  static const String className = 'Operation';
  OperationModel fromParse(ParseObject parseObject) {
    OperationModel model = OperationModel(
      id: parseObject.objectId!,
      organizer:
          UserEntity().fromParse(parseObject.get('organizer') as ParseUser),
      name: parseObject.get<String>('name')!,
      boss: parseObject.get<String>('boss') ?? '',
      history: parseObject.get<String>('history'),
      isDeleted: parseObject.get<bool>('isDeleted') ?? false,
    );
    return model;
  }

  Future<ParseObject> toParse(OperationModel model) async {
    final parseObject = ParseObject(OperationEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    var currentUser = await ParseUser.currentUser() as ParseUser?;
    parseObject.set('organizer', currentUser);
    parseObject.set('name', model.name);
    parseObject.set('boss', model.boss);
    parseObject.set('history', model.history);
    parseObject.set('isDeleted', model.isDeleted);
    return parseObject;
  }

  ParseObject? toParseUpdateRelationOperators(
      {required String objectId,
      required List<String> modelIdList,
      required bool add}) {
    print('objectId:$objectId, modelIdList:${modelIdList.join("|")},add:$add');
    final parseObject = ParseObject(OperationEntity.className);
    parseObject.objectId = objectId;
    if (add) {
      if (modelIdList.isEmpty) {
        parseObject.unset('operators');
      } else {
        parseObject.addRelation(
          'operators',
          modelIdList
              .map(
                (element) =>
                    ParseObject(UserEntity.className)..objectId = element,
              )
              .toList(),
        );
      }
    } else {
      if (modelIdList.isEmpty) {
        parseObject.unset('operators');
      } else {
        parseObject.removeRelation(
            'operators',
            modelIdList
                .map((element) =>
                    ParseObject(UserEntity.className)..objectId = element)
                .toList());
      }
    }
    if (modelIdList.isEmpty) {
      return null;
    } else {
      return parseObject;
    }
  }

  ParseObject? toParseUpdateRelationInvolveds(
      {required String objectId,
      required List<String> modelIdList,
      required bool add}) {
    final parseObject = ParseObject(OperationEntity.className);
    parseObject.objectId = objectId;
    if (add) {
      if (modelIdList.isEmpty) {
        parseObject.unset('involveds');
      } else {
        parseObject.addRelation(
          'involveds',
          modelIdList
              .map(
                (element) =>
                    ParseObject(PersonEntity.className)..objectId = element,
              )
              .toList(),
        );
      }
    } else {
      if (modelIdList.isEmpty) {
        parseObject.unset('involveds');
      } else {
        parseObject.removeRelation(
            'involveds',
            modelIdList
                .map((element) =>
                    ParseObject(PersonEntity.className)..objectId = element)
                .toList());
      }
    }
    if (modelIdList.isEmpty) {
      return null;
    } else {
      return parseObject;
    }
  }

  // ParseObject? toParseUpdateRelationInvolveds(
  //     {required String personId,
  //     required List<PersonModel> modelList,
  //     bool add = false}) {
  //   final parseObject = ParseObject(OperationEntity.className);
  //   parseObject.objectId = personId;
  //   List<String> itemList = [];
  //   if (add) {
  //     if (modelList.isEmpty) {
  //       parseObject.unset('involveds');
  //     } else {
  //       for (var element in modelList) {
  //         if (element.isSelected == false) {
  //           itemList.add(element.id!);
  //         }
  //       }
  //       if (itemList.isNotEmpty) {
  //         parseObject.addRelation(
  //           'involveds',
  //           itemList
  //               .map((element) =>
  //                   ParseObject(PersonEntity.className)..objectId = element)
  //               .toList(),
  //         );
  //       }
  //     }
  //   } else {
  //     if (modelList.isEmpty) {
  //       parseObject.unset('involveds');
  //     } else {
  //       for (var element in modelList) {
  //         if (element.isSelected == true) {
  //           itemList.add(element.id!);
  //         }
  //       }
  //       if (itemList.isNotEmpty) {
  //         parseObject.removeRelation(
  //           'involveds',
  //           itemList
  //               .map((element) =>
  //                   ParseObject(PersonEntity.className)..objectId = element)
  //               .toList(),
  //         );
  //       }
  //     }
  //   }

  //   if (modelList.isNotEmpty && itemList.isEmpty) {
  //     return null;
  //   } else {
  //     return parseObject;
  //   }
  // }
}
