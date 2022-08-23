import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/auth/auth_repository_b4a.dart';
import 'package:noctua/app/data/repositories/auth_repository.dart';
import 'package:noctua/app/domain/usecases/auth/auth_usecase.dart';
import 'package:noctua/app/domain/usecases/auth/auth_usecase_impl.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_controller.dart';

class SplashDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthRepository>(
      AuthRepositoryB4a(),
    );
    Get.put<AuthUseCase>(
      AuthUseCaseImpl(
        authRepository: Get.find(),
      ),
    );
    Get.put<SplashController>(
      SplashController(
        authUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
