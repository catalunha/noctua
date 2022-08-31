import 'package:noctua/app/data/repositories/law_repository.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/usecases/law/law_usecase.dart';

class LawUseCaseImpl implements LawUseCase {
  final LawRepository _repository;
  LawUseCaseImpl({
    required LawRepository repository,
  }) : _repository = repository;

  @override
  Future<List<LawModel>> list() async => await _repository.list();
}
