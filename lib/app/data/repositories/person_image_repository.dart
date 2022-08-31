import 'package:noctua/app/domain/models/person_image_model.dart';

abstract class PersonImageRepository {
  Future<String> add(PersonImageModel model);
  Future<void> delete(String id);
}
