import 'package:get/get.dart';
import 'package:noctua/app/domain/usecases/auth/auth_usecase.dart';
import 'package:noctua/app/routes.dart';
import 'package:noctua/app/view/controllers/utils/loader_mixin.dart';
import 'package:noctua/app/view/controllers/utils/message_mixin.dart';

class HomeController extends GetxController with LoaderMixin, MessageMixin {
  final AuthUseCase _authUseCase;

  HomeController({
    required AuthUseCase authUseCase,
  }) : _authUseCase = authUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> logout() async {
    //print('em home logout ');
    await _authUseCase.logout();
    Get.offAllNamed(Routes.authLogin);
  }
}
