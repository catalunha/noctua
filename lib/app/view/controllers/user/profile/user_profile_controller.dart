import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noctua/app/data/b4a/entity/user_profile_entity.dart';
import 'package:noctua/app/data/b4a/user/profile/user_profile_repository_exception.dart';
import 'package:noctua/app/domain/models/user_profile_model.dart';
import 'package:noctua/app/domain/usecases/user/profile/user_profile_usecase.dart';
import 'package:noctua/app/domain/utils/xfile_to_parsefile.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:noctua/app/view/controllers/utils/loader_mixin.dart';
import 'package:noctua/app/view/controllers/utils/message_mixin.dart';

class UserProfileController extends GetxController
    with LoaderMixin, MessageMixin {
  final UserProfileUseCase _userProfileUseCase;
  UserProfileController({required UserProfileUseCase userProfileUseCase})
      : _userProfileUseCase = userProfileUseCase;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _userProfile = Rxn<UserProfileModel>();
  UserProfileModel? get userProfile => _userProfile.value;

  XFile? _xfile;
  set xfile(XFile? xfile) {
    _xfile = xfile;
  }

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    UserProfileModel? model = Get.arguments;
    // //print('Get.arguments = ${Get.arguments}');
    _userProfile(model);
    super.onInit();
  }

  Future<void> append({
    String? name,
    String? description,
    String? phone,
    String? community,
  }) async {
    try {
      _loading(true);

      // if (_userProfile.value == null) {
      //   //print('profile create');
      //   var userProfile = UserProfileModel(
      //     id: null,
      //     fullName: fullName,
      //     nameTag: nameTag,
      //     description: description,
      //     isWoman: isWoman,
      //     discord: discord,
      //     telegram: telegram,
      //   );
      //    String userawait _userProfileUseCase.create(userProfile);
      //   if (_xfile != null) {
      //     await XFileToParseFile.xFileToParseFile(
      //       xfile: _xfile!,
      //       className: 'Profile',
      //       attributeClass: 'photo',
      //     );
      //   }
      //   //print(userProfile);

      // } else {
      var userProfile = _userProfile.value!.copyWith(
        name: name,
        description: description,
        phone: phone,
        community: community,
      );
      String userProfileId = await _userProfileUseCase.update(userProfile);
      if (_xfile != null) {
        await XFileToParseFile.xFileToParseFile(
          xfile: _xfile!,
          className: UserProfileEntity.className,
          objectId: userProfileId,
          objectAttribute: 'photo',
        );
      }
      // }
      SplashController splashController = Get.find();
      await splashController.updateUserProfile();
    } on UserProfileRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em UserProfileController',
        message: 'Não foi possivel salvar o perfil',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
