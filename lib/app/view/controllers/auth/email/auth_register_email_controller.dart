import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/auth/auth_repository_exception.dart';
import 'package:noctua/app/domain/usecases/auth/auth_usecase.dart';
import 'package:noctua/app/routes.dart';
import 'package:noctua/app/view/controllers/utils/loader_mixin.dart';
import 'package:noctua/app/view/controllers/utils/message_mixin.dart';

class AuthRegisterEmailController extends GetxController
    with LoaderMixin, MessageMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final AuthUseCase _authUseCase;
  AuthRegisterEmailController({required AuthUseCase authUseCase})
      : _authUseCase = authUseCase;

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  Future<void> registerEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authUseCase.registerEmail(
        email: email,
        password: password,
      );
      _loading(true);
      print('após registerEmail ');
      if (user != null) {
        print('Success register');
        Get.offAllNamed(Routes.authLogin);
      } else {
        print('user==null in register');
        // _authUseCase.logout();
        _message.value = MessageModel(
          title: 'Erro',
          message: 'Em registrar usuário',
          isError: true,
        );
      }
    } on AuthRepositoryException {
      print('error em  registerEmail');
      _authUseCase.logout();
      _message.value = MessageModel(
        title: 'AuthRepositoryException',
        message: 'Em registrar usuário',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
