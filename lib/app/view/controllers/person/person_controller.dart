import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noctua/app/data/b4a/entity/person_entity.dart';
import 'package:noctua/app/data/b4a/entity/person_image_entity.dart';
import 'package:noctua/app/data/b4a/person/person_repository_exception.dart';
import 'package:noctua/app/data/b4a/person_image/person_image_repository_exception.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';
import 'package:noctua/app/domain/usecases/law/law_usecase.dart';
import 'package:noctua/app/domain/usecases/person/person_filter.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
import 'package:noctua/app/domain/usecases/person_image/person_image_usecase.dart';
import 'package:noctua/app/domain/utils/xfile_to_parsefile.dart';
import 'package:noctua/app/routes.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:noctua/app/view/controllers/utils/loader_mixin.dart';
import 'package:noctua/app/view/controllers/utils/message_mixin.dart';

class PersonController extends GetxController with LoaderMixin, MessageMixin {
  final PersonUseCase _personUseCase;
  final PersonImageUseCase _personImageUseCase;
  final LawUseCase _lawUseCase;

  PersonController({
    required PersonUseCase personUseCase,
    required PersonImageUseCase personImageUseCase,
    required LawUseCase lawUseCase,
  })  : _personUseCase = personUseCase,
        _personImageUseCase = personImageUseCase,
        _lawUseCase = lawUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final _personList = <PersonModel>[].obs;
  List<PersonModel> get personList => _personList;

  var lawList = <LawModel>[].obs;
  var lawIdSelectedList = <String>[].obs;

  final _person = Rxn<PersonModel>();
  PersonModel? get person => _person.value;

  XFile? xfile;

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

  void addEditImage(String id) {
    var phraseTemp = _personList.firstWhere((element) => element.id == id);
    _person(phraseTemp);
    xfile = null;
    Get.toNamed(Routes.personAddEditImage);
  }

  void addEditLaw(String id) async {
    var phraseTemp = _personList.firstWhere((element) => element.id == id);
    _person(phraseTemp);
    List<LawModel> temp = await _lawUseCase.list();
    lawList(temp);
    lawIdSelectedList.clear();
    for (var element in person!.laws!) {
      lawIdSelectedList.add(element.id!);
    }
    Get.toNamed(Routes.personAddEditLaw);
  }

  void onAddEditlaw() async {
    try {
      _loading(true);
      List<LawModel> lawsOld = [...person!.laws!];
      List<LawModel> lawsNew = [];
      List<String> lawIdSelectedListUpdated = [...lawIdSelectedList];
      // laws.removeWhere((element) => !lawIdSelectedList.contains(element.id));
      for (var law in lawsOld) {
        if (lawIdSelectedList.contains(law.id)) {
          lawsNew.add(law);
          lawIdSelectedListUpdated.remove(law.id);
        } else {
          lawsNew.add(law.copyWith(isDeleted: true));
        }
      }
      for (var lawUpdated in lawIdSelectedListUpdated) {
        lawsNew.add(lawList
            .firstWhere((e) => e.id == lawUpdated)
            .copyWith(isDeleted: false));
      }
      PersonModel personModel = _person.value!.copyWith(laws: lawsNew);
      //print(personModel.laws);
      await _personUseCase.updateRelation(personModel);
    } catch (e) {
      //print('====================');
      //print(e);
      _message.value = MessageModel(
        title: 'Erro',
        message: 'Não foi possivel atualizar leis',
        isError: true,
      );
    } finally {
      await listAll();
      _loading(false);
      Get.back();
    }
  }

  onUpdateLawIdSelectedList(String lawId) {
    if (lawIdSelectedList.contains(lawId)) {
      lawIdSelectedList.remove(lawId);
    } else {
      lawIdSelectedList.add(lawId);
    }
  }

  void edit(String id) {
    var phraseTemp = _personList.firstWhere((element) => element.id == id);
    _person(phraseTemp);
    onSelectedDate();
    xfile = null;

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
    // debug////print'addedit $phrase');
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
          images: [],
          laws: []);
      String personId = await _personUseCase.addEdit(model);
      if (xfile != null) {
        await XFileToParseFile.xFileToParseFile(
          xfile: xfile!,
          className: PersonEntity.className,
          objectId: personId,
          objectAttribute: 'photo',
        );
      }
      xfile = null;
    } on PersonRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar os dados',
        isError: true,
      );
    } finally {
      listAll();
      _loading(false);
      Get.back();
    }
  }

  Future<void> onAddEditImage({
    String note = '',
  }) async {
    try {
      _loading(true);
      if (xfile != null) {
        PersonImageModel personImageModel = PersonImageModel(
          note: note,
          isDeleted: false,
        );
        String personImageId = await _personImageUseCase.add(personImageModel);
        String? url = await XFileToParseFile.xFileToParseFile(
          xfile: xfile!,
          className: PersonImageEntity.className,
          objectId: personImageId,
          objectAttribute: 'photo',
        );
        xfile = null;
        personImageModel =
            personImageModel.copyWith(id: personImageId, photo: url);
        List<PersonImageModel> images = person!.images!;
        images.add(personImageModel);
        // _person.value!.images!.add(personImageModel);
        PersonModel personModel = _person.value!.copyWith(images: images);
        _person.refresh();
        await _personUseCase.updateRelation(personModel);
      }
    } on PersonImageRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar os dados',
        isError: true,
      );
    } finally {
      await listAll();
      _loading(false);
      // Get.back();
    }
  }

  onDeleteImage(String objectImageId) async {
    try {
      _loading(true);

      //print('Delete: $objectImageId');
      // // //print(_person.value!.images!.length);
      // PersonImageModel model =
      //     _person.value!.images!.firstWhere((e) => e.id == objectImageId);
      // _person.value!.images!.removeWhere((e) => e.id == objectImageId);
      // PersonImageModel modelTemp = model.copyWith(isDeleted: true);
      // _person.value!.images!.add(modelTemp);
      List<PersonImageModel> images = [...person!.images!];
      PersonImageModel model = images.firstWhere((e) => e.id == objectImageId);
      //print('atualizando: ${model.id}');
      PersonImageModel modelTemp = model.copyWith(isDeleted: true);
      images.removeWhere((e) => e.id == objectImageId);
      images.add(modelTemp);
      PersonModel personModel = _person.value!.copyWith(images: images);
      _person.update((val) {
        // val.images!.add(modelTemp);
        val!.images!.removeWhere((e) => e.id == objectImageId);
      });

      _person.refresh();

      // //print(person!.images!.length);
      // //print(_person.value!.images!.length);
      await _personUseCase.updateRelation(personModel);
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro',
        message: 'Não foi possivel apagar esta imagem',
        isError: true,
      );
    } finally {
      await listAll();
      _loading(false);
      // Get.back();
    }
  }
}
