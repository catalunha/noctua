import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/auth/email/auth_register_email_dependencies.dart';
import 'package:noctua/app/view/controllers/auth/login/login_dependencies.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_dependencies.dart';
import 'package:noctua/app/view/controllers/home/home_dependencies.dart';
import 'package:noctua/app/view/controllers/user/profile/user_profile_dependencies.dart';
import 'package:noctua/app/view/pages/auth/login/auth_login_page.dart';
import 'package:noctua/app/view/pages/auth/register/email/auth_register_email.page.dart';
import 'package:noctua/app/view/pages/auth/splash/splash_page.dart';
import 'package:noctua/app/view/pages/home/home_page.dart';
import 'package:noctua/app/view/pages/user/profile/user_profile_page.dart';

class Routes {
  static const splash = '/';

  static const authLogin = '/auth/login';
  static const authRegisterEmail = '/auth/register/email';

  static const home = '/home';
  static const userProfile = '/user/profile';

  static final pageList = [
    GetPage(
      name: Routes.splash,
      binding: SplashDependencies(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.authLogin,
      binding: AuthLoginDependencies(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.authRegisterEmail,
      binding: AuthRegisterEmailDependencies(),
      page: () => AuthRegisterEmailPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeDependencies(),
      bindings: [
        HomeDependencies(),
      ],
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.userProfile,
      binding: UserProfileDependencies(),
      page: () => UserProfilePage(),
    ),
  ];
}
