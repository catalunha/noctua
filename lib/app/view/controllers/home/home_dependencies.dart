import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/home/home_controller.dart';

class HomeDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(authUseCase: Get.find()),
    );
  }
}
