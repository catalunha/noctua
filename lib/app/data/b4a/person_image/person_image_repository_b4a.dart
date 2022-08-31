import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/entity/person_image_entity.dart';
import 'package:noctua/app/data/b4a/person_image/person_image_repository_exception.dart';
import 'package:noctua/app/data/repositories/person_image_repository.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonImageRepositoryB4a extends GetxService
    implements PersonImageRepository {
  @override
  Future<String> add(PersonImageModel model) async {
    final parseObject = await PersonImageEntity().toParse(model);
    final ParseResponse parseResponse = await parseObject.save();
    if (parseResponse.success && parseResponse.results != null) {
      ParseObject parseObject = parseResponse.results!.first as ParseObject;
      return parseObject.objectId!;
    } else {
      throw PersonImageRepositoryException(
          code: 1, message: 'Não foi possivel cadastrar/atualizar a foto.');
    }
  }

  @override
  Future<void> delete(String id) async {
    var parseObject = ParseObject(PersonImageEntity.className)..objectId = id;
    parseObject.set('isArchived', true);
    await parseObject.delete();
  }
}
