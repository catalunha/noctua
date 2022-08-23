import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/auth/email/auth_register_email_controller.dart';

class AuthRegisterEmailDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRegisterEmailController>(
        () => AuthRegisterEmailController(authUseCase: Get.find()));
  }
}
