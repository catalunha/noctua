import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/auth/email/auth_register_email_dependencies.dart';
import 'package:noctua/app/view/controllers/auth/login/login_dependencies.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_dependencies.dart';
import 'package:noctua/app/view/controllers/home/home_dependencies.dart';
import 'package:noctua/app/view/controllers/operation/operation_dependencies.dart';
import 'package:noctua/app/view/controllers/person/person_dependencies.dart';
import 'package:noctua/app/view/controllers/person/search/people_search_dependencies.dart';
import 'package:noctua/app/view/controllers/user/profile/user_profile_dependencies.dart';
import 'package:noctua/app/view/pages/auth/login/auth_login_page.dart';
import 'package:noctua/app/view/pages/auth/register/email/auth_register_email.page.dart';
import 'package:noctua/app/view/pages/auth/splash/splash_page.dart';
import 'package:noctua/app/view/pages/home/home_page.dart';
import 'package:noctua/app/view/pages/operation/operation_involveds_page.dart';
import 'package:noctua/app/view/pages/operation/operation_operators_page.dart';
import 'package:noctua/app/view/pages/operation/operation_addedit_page.dart';
import 'package:noctua/app/view/pages/operation/operation_page.dart';
import 'package:noctua/app/view/pages/person/parts/image_get_crop.dart';
import 'package:noctua/app/view/pages/person/person_addedit_group.dart';
import 'package:noctua/app/view/pages/person/person_addedit_image.dart';
import 'package:noctua/app/view/pages/person/person_addedit_law.dart';
import 'package:noctua/app/view/pages/person/person_addedit_page.dart';
import 'package:noctua/app/view/pages/person/person_data.dart';
import 'package:noctua/app/view/pages/person/person_search_page.dart';
import 'package:noctua/app/view/pages/person/person_search_result_page.dart';
import 'package:noctua/app/view/pages/user/profile/user_profile_page.dart';

class Routes {
  static const splash = '/';

  static const authLogin = '/auth/login';
  static const authRegisterEmail = '/auth/register/email';

  static const home = '/home';
  static const userProfile = '/user/profile';

  static const personAddEdit = '/person/addedit';
  static const personAddEditImage = '/person/addedit/image';
  static const personAddEditLaw = '/person/addedit/law';
  static const personAddEditGroup = '/person/addedit/group';
  static const personAddPhoto = '/person/add/photo';
  static const personData = '/person/data';
  static const personSearch = '/person/search';
  static const personSearchResult = '/person/search/result';

  static const operation = '/operation';
  static const operationAddEdit = '/operation/addedit';
  static const operationOperators = '/operation/operators';
  static const operationInvolveds = '/operation/involveds';

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
        PersonDependencies(),
      ],
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.userProfile,
      binding: UserProfileDependencies(),
      page: () => UserProfilePage(),
    ),
    GetPage(
      name: Routes.personAddEdit,
      page: () => PhraseAddEditPage(),
    ),
    GetPage(
      name: Routes.personData,
      page: () => PersonData(),
    ),
    GetPage(
      name: Routes.personAddEditImage,
      page: () => PersonAddEditImage(),
    ),
    GetPage(
      name: Routes.personAddEditLaw,
      page: () => PersonAddEditLaw(),
    ),
    GetPage(
      name: Routes.personAddEditGroup,
      page: () => PersonAddEditGroup(),
    ),
    GetPage(
      name: Routes.personSearch,
      binding: PersonSearchDependencies(),
      page: () => PersonSearchPage(),
    ),
    GetPage(
      name: Routes.personSearchResult,
      page: () => PersonSearchResultPage(),
    ),
    GetPage(
      name: Routes.personAddPhoto,
      page: () => ImageGetCrop(),
    ),
    GetPage(
      name: Routes.operation,
      binding: OperationDependencies(),
      page: () => OperationPage(),
    ),
    GetPage(
      name: Routes.operationAddEdit,
      page: () => OperationAddEditPage(),
    ),
    GetPage(
      name: Routes.operationOperators,
      page: () => OperationOperators(),
    ),
    GetPage(
      name: Routes.operationInvolveds,
      page: () => OperationInvolveds(),
    ),
  ];
}
