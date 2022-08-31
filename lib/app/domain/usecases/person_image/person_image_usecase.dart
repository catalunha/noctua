import 'package:noctua/app/domain/models/person_image_model.dart';

abstract class PersonImageUseCase {
  Future<String> add(PersonImageModel model);
  Future<void> delete(String id);
}
