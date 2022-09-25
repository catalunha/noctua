import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/group/group_repository_b4a.dart';
import 'package:noctua/app/data/b4a/law/law_repository_b4a.dart';
import 'package:noctua/app/data/b4a/person/person_repository_b4a.dart';
import 'package:noctua/app/data/b4a/person_image/person_image_repository_b4a.dart';
import 'package:noctua/app/data/repositories/group_repository.dart';
import 'package:noctua/app/data/repositories/law_repository.dart';
import 'package:noctua/app/data/repositories/person_image_repository.dart';
import 'package:noctua/app/data/repositories/person_repository.dart';
import 'package:noctua/app/domain/usecases/group/group_usecase.dart';
import 'package:noctua/app/domain/usecases/group/group_usecase_impl.dart';
import 'package:noctua/app/domain/usecases/law/law_usecase.dart';
import 'package:noctua/app/domain/usecases/law/law_usecase_impl.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase_impl.dart';
import 'package:noctua/app/domain/usecases/person_image/person_image_usecase.dart';
import 'package:noctua/app/domain/usecases/person_image/person_image_usecase_impl.dart';
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
    Get.put<PersonImageRepository>(
      PersonImageRepositoryB4a(),
    );
    Get.put<PersonImageUseCase>(
      PersonImageUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.put<LawRepository>(
      LawRepositoryB4a(),
    );
    Get.put<LawUseCase>(
      LawUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.put<GroupRepository>(
      GroupRepositoryB4a(),
    );
    Get.put<GroupUseCase>(
      GroupUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.put<PersonController>(
      PersonController(
        personUseCase: Get.find(),
        personImageUseCase: Get.find(),
        lawUseCase: Get.find(),
        groupUseCase: Get.find(),
      ),
    );
  }
}
