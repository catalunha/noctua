import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/operation/operation_repository_b4a.dart';
import 'package:noctua/app/data/b4a/person/person_repository_b4a.dart';
import 'package:noctua/app/data/b4a/user/user/user_repository_b4a.dart';
import 'package:noctua/app/data/repositories/operation_repository.dart';
import 'package:noctua/app/data/repositories/person_repository.dart';
import 'package:noctua/app/data/repositories/user_repository.dart';
import 'package:noctua/app/domain/usecases/operation/operation_usecase.dart';
import 'package:noctua/app/domain/usecases/operation/operation_usecase_impl.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase_impl.dart';
import 'package:noctua/app/domain/usecases/user/user/user_usecase.dart';
import 'package:noctua/app/domain/usecases/user/user/user_usecase_impl.dart';
import 'package:noctua/app/view/controllers/operation/operation_controller.dart';

class OperationDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<OperationRepository>(
      OperationRepositoryB4a(),
    );
    Get.put<OperationUsecase>(
      OperationUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.lazyPut<UserRepository>(
      () => UserRepositoryB4a(),
    );
    Get.lazyPut<UserUseCase>(
      () => UserUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.lazyPut<PersonRepository>(
      () => PersonRepositoryB4a(),
    );
    Get.lazyPut<PersonUseCase>(
      () => PersonUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.put<OperationController>(
      OperationController(
        operationUseCase: Get.find(),
        userUseCase: Get.find(),
        personUseCase: Get.find(),
      ),
    );
  }
}
