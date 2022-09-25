import 'package:noctua/app/data/repositories/group_repository.dart';
import 'package:noctua/app/domain/models/group_model.dart';
import 'package:noctua/app/domain/usecases/group/group_usecase.dart';

class GroupUseCaseImpl implements GroupUseCase {
  final GroupRepository _repository;
  GroupUseCaseImpl({
    required GroupRepository repository,
  }) : _repository = repository;

  @override
  Future<List<GroupModel>> list() async => await _repository.list();
}
