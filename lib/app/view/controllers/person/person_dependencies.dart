import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/person/person_repository_b4a.dart';
import 'package:noctua/app/data/repositories/person_repository.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase_impl.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';

class PersonDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<PersonRepository>(
      PersonRepositoryB4a(),
    );
    Get.put<PersonUseCase>(
      PersonUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.put<PersonController>(
      PersonController(personUseCase: Get.find()),
    );
  }
}
