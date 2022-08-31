import 'package:noctua/app/data/repositories/person_image_repository.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/usecases/person_image/person_image_usecase.dart';

class PersonImageUseCaseImpl implements PersonImageUseCase {
  final PersonImageRepository _repository;
  PersonImageUseCaseImpl({
    required PersonImageRepository repository,
  }) : _repository = repository;

  @override
  Future<void> delete(String id) async => await _repository.delete(id);

  @override
  Future<String> add(PersonImageModel model) async =>
      await _repository.add(model);
}
