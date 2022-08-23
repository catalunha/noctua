import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/auth/login/login_controller.dart';

class AuthLoginDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(
          authUseCase: Get.find(),
          splashController: Get.find(),
        ));
  }
}
