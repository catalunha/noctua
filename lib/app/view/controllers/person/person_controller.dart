import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noctua/app/data/b4a/entity/person_entity.dart';
import 'package:noctua/app/data/b4a/person/person_repository_exception.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';
import 'package:noctua/app/domain/usecases/person/person_filter.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
import 'package:noctua/app/domain/utils/xfile_to_parsefile.dart';
import 'package:noctua/app/routes.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:noctua/app/view/controllers/utils/loader_mixin.dart';
import 'package:noctua/app/view/controllers/utils/message_mixin.dart';

class PersonController extends GetxController with LoaderMixin, MessageMixin {
  final PersonUseCase _personUseCase;

  PersonController({
    required PersonUseCase personUseCase,
  }) : _personUseCase = personUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final _personList = <PersonModel>[].obs;
  List<PersonModel> get personList => _personList;

  final _person = Rxn<PersonModel>();
  PersonModel? get person => _person.value;

  XFile? _xfile;
  set xfile(XFile? xfile) {
    _xfile = xfile;
  }

  final Rxn<DateTime> _selectedDate = Rxn<DateTime>();
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? selectedDate1) {
    _selectedDate.value = selectedDate1;
  }

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> listAll() async {
    _loading(true);
    _personList.clear();
    PersonFilter personFilter = PersonFilter();
    List<PersonModel> temp = await _personUseCase.list(personFilter);
    _personList(temp);
    print(_personList.length);
    _loading(false);
  }

  void onSelectedDate() {
    if (person != null) {
      selectedDate = person!.birthday;
    } else {
      selectedDate = null;
    }
  }

  void add() {
    _person.value = null;
    xfile = null;
    onSelectedDate();
    Get.toNamed(Routes.personAddEdit);
  }

  void edit(String id) {
    var phraseTemp = _personList.firstWhere((element) => element.id == id);
    _person(phraseTemp);
    onSelectedDate();
    Get.toNamed(Routes.personAddEdit);
  }

  void viewData(String id) {
    var phraseTemp = _personList.firstWhere((element) => element.id == id);
    _person(phraseTemp);
    Get.toNamed(Routes.personData);
  }

  Future<void> addedit({
    bool isMale = true,
    String name = '',
    String cpf = '',
    String alias = '',
    String mother = '',
    String note = '',
    String history = '',
    bool isArchived = false,
    bool isPublic = false,
    bool isDeleted = false,
  }) async {
    // debug//print'addedit $phrase');
    try {
      _loading(true);
      UserModel userModel;
      String? modelId;
      if (person == null) {
        SplashController splashController = Get.find();
        userModel = splashController.userModel!;
      } else {
        userModel = person!.user;
        modelId = person!.id;
      }
      List<String> aliasTemp = alias.split(',').map((e) => e.trim()).toList();
      aliasTemp.removeWhere((e) => e.isEmpty);
      PersonModel model = PersonModel(
        id: modelId,
        user: userModel,
        isMale: isMale,
        name: name,
        cpf: cpf,
        birthday: selectedDate,
        alias: aliasTemp,
        mother: mother,
        history: history,
        note: note,
        isArchived: isArchived,
        isPublic: isPublic,
        isDeleted: isDeleted,
      );
      String personId = await _personUseCase.add(model);
      if (_xfile != null) {
        await XFileToParseFile.xFileToParseFile(
          xfile: _xfile!,
          className: PersonEntity.className,
          objectId: personId,
          objectAttribute: 'photo',
        );
      }
      // }
      SplashController splashController = Get.find();
      await splashController.updateUserProfile();
    } on PersonRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar os dados',
        isError: true,
      );
    } finally {
      listAll();
      _loading(false);
    }
  }
}
