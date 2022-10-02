import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noctua/app/data/b4a/entity/person_entity.dart';
import 'package:noctua/app/data/b4a/entity/person_image_entity.dart';
import 'package:noctua/app/data/b4a/person/person_repository_exception.dart';
import 'package:noctua/app/data/b4a/person_image/person_image_repository_exception.dart';
import 'package:noctua/app/domain/models/group_model.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';
import 'package:noctua/app/domain/usecases/group/group_usecase.dart';
import 'package:noctua/app/domain/usecases/law/law_usecase.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
import 'package:noctua/app/domain/usecases/person_image/person_image_usecase.dart';
import 'package:noctua/app/domain/utils/pagination.dart';
import 'package:noctua/app/domain/utils/xfile_to_parsefile.dart';
import 'package:noctua/app/routes.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:noctua/app/view/controllers/utils/loader_mixin.dart';
import 'package:noctua/app/view/controllers/utils/message_mixin.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonController extends GetxController with LoaderMixin, MessageMixin {
  final PersonUseCase _personUseCase;
  final PersonImageUseCase _personImageUseCase;
  final LawUseCase _lawUseCase;
  final GroupUseCase _groupUseCase;

  PersonController({
    required PersonUseCase personUseCase,
    required PersonImageUseCase personImageUseCase,
    required LawUseCase lawUseCase,
    required GroupUseCase groupUseCase,
  })  : _personUseCase = personUseCase,
        _personImageUseCase = personImageUseCase,
        _groupUseCase = groupUseCase,
        _lawUseCase = lawUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final _personList = <PersonModel>[].obs;
  List<PersonModel> get personList => _personList;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;
  late final Worker paginationWorker;

  var personImageList = <PersonImageModel>[].obs;
  // List<LawModel> lawStatusList = [];
  // List<GroupModel> groupStatusList = [];

  var laws = <LawModel>[].obs;
  // var lawIdSelectedList = <String>[].obs;
  var groups = <GroupModel>[].obs;
  var addedIds = <String>[].obs;
  var removedIds = <String>[].obs;
  var actualIds = <String>[].obs;

  final _person = Rxn<PersonModel>();
  PersonModel? get person => _person.value;

  XFile? pickedXFile;
  setPickedXFile(XFile? value) {
    pickedXFile = value;
  }

  CroppedFile? croppedFile;
  setCroppedFile(CroppedFile? value) {
    croppedFile = value;
  }

  final Rxn<DateTime> _selectedDate = Rxn<DateTime>();
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? selectedDate1) {
    // _selectedDate.value = selectedDate1.;
    print('set date');
    if (selectedDate1 != null) {
      _selectedDate.value =
          DateTime(selectedDate1.year, selectedDate1.month, selectedDate1.day);
    }
  }

// Analisar colocar isto no onReady
// colocar loading na busca da lista
  @override
  void onInit() async {
    _personList.clear();
    paginationWorker = ever(_pagination, (_) => listAll());
    _changePagination(1, 2);
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  @override
  void onClose() {
    paginationWorker();
    super.onClose();
  }

// rever objetos reativos
  void _changePagination(int page, int limit) {
    _pagination.update((val) {
      val!.page = page;
      val.limit = limit;
    });
    // _pagination(Pagination()
    //   ..page = page
    //   ..limit = limit);
    // _pagination.refresh();
  }

  void nextPage() {
    _changePagination(_pagination.value.page + 1, _pagination.value.limit);
  }

  Future<void> listAll() async {
    print('=========> listaAll');
    _loading(true);
    // _personList.clear();
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));
    List<PersonModel> temp =
        await _personUseCase.list(query, _pagination.value);
    if (temp.isEmpty) {
      _lastPage.value = true;
    }
    _personList.addAll(temp);
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
    pickedXFile = null;
    croppedFile = null;
    onSelectedDate();
    Get.toNamed(Routes.personAddEdit);
  }

  void edit(PersonModel personModel) {
    // var phraseTemp =
    //     _personList.firstWhere((element) => element.id == personModel.id);
    // _person(phraseTemp);
    _person(personModel);
    onSelectedDate();
    pickedXFile = null;
    croppedFile = null;

    Get.toNamed(Routes.personAddEdit);
  }
  // void edit(String id) {
  //   var phraseTemp = _personList.firstWhere((element) => element.id == id);
  //   _person(phraseTemp);
  //   onSelectedDate();
  //   pickedXFile = null;
  //   croppedFile = null;

  //   Get.toNamed(Routes.personAddEdit);
  // }

  Future<void> addedit({
    bool isFemale = true,
    String name = '',
    String cpf = '',
    String alias = '',
    String mother = '',
    String mark = '',
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
      String? photo;
      if (person == null) {
        SplashController splashController = Get.find();
        userModel = splashController.userModel!;
      } else {
        userModel = person!.user;
        modelId = person!.id;
        photo = person!.photo;
      }
      // List<String> aliasTemp =
      //     alias.split(',').map((e) => e.trim().toLowerCase()).toList();
      // aliasTemp.removeWhere((e) => e.isEmpty);
      // List<String> nameWordsTemp =
      //     name.split(' ').map((e) => e.trim().toLowerCase()).toList();
      // List<String> motherWordsTemp =
      //     mother.split(' ').map((e) => e.trim().toLowerCase()).toList();
      PersonModel model = PersonModel(
        id: modelId,
        user: userModel,
        isFemale: isFemale,
        name: name,
        cpf: cpf,
        birthday: selectedDate,
        alias: PersonModel.onTextSplit(alias),
        mother: mother,
        history: history,
        marks: mark,
        isArchived: isArchived,
        isPublic: isPublic,
        isDeleted: isDeleted,
      );
      String personId = await _personUseCase.addEdit(model);

      if (croppedFile != null) {
        photo = await XFileToParseFile.xFileToParseFile(
          nameOfFile: pickedXFile!.name,
          pathOfFile: croppedFile!.path,
          fileInListOfBytes: await croppedFile!.readAsBytes(),
          className: PersonEntity.className,
          objectId: personId,
          objectAttribute: 'photo',
        );
      } else if (pickedXFile != null) {
        photo = await XFileToParseFile.xFileToParseFile(
          nameOfFile: pickedXFile!.name,
          pathOfFile: pickedXFile!.path,
          fileInListOfBytes: await pickedXFile!.readAsBytes(),
          className: PersonEntity.className,
          objectId: personId,
          objectAttribute: 'photo',
        );
      }
      pickedXFile = null;
      croppedFile = null;
      // PersonModel modelFinal = model.copyWith(id: personId, photo: photo);
      // int index = _personList.indexWhere((e) => e.id == personId);
      // if (index >= 0) _personList.fillRange(index, index + 1, modelFinal);
    } on PersonRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar os dados',
        isError: true,
      );
    } finally {
      _personList.clear();
      _lastPage.value = false;
      _changePagination(1, 2);
      _loading(false);
      Get.back();
    }
  }

  void viewData(PersonModel personModel) async {
    // var phraseTemp = _personList.firstWhere((element) => element.id == id);
    // _person(phraseTemp);
    _person(personModel);

    List<PersonImageModel> images =
        await _personUseCase.readRelationImages(personModel.id!);
    List<LawModel> laws =
        await _personUseCase.readRelationLaws(personModel.id!);
    List<GroupModel> groups =
        await _personUseCase.readRelationGroups(personModel.id!);
    _person.value =
        _person.value!.copyWith(images: images, laws: laws, groups: groups);
    _person.refresh();
    Get.toNamed(Routes.personData, arguments: _person.value);
  }

  void addDeleteGroup(PersonModel personModel) async {
    _person(personModel);

    actualIds.clear();
    addedIds.clear();
    removedIds.clear();
    List<GroupModel> actual =
        await _personUseCase.readRelationGroups(personModel.id!);
    for (var element in actual) {
      actualIds.add(element.id!);
    }
    List<GroupModel> all = await _groupUseCase.list();
    groups(all);
    Get.toNamed(Routes.personAddEditGroup);
  }

  onUpdateGroupIdInList(String id) {
    print(id);
    print('actualIdsGroups: $actualIds');
    print('addedIdsGroups: $addedIds');
    print('removedIdsGroups: $removedIds');
    if (!actualIds.contains(id)) {
      print('add...');
      if (addedIds.contains(id)) {
        addedIds.remove(id);
      } else {
        addedIds.add(id);
      }
    }
    if (actualIds.contains(id)) {
      if (removedIds.contains(id)) {
        removedIds.remove(id);
      } else {
        removedIds.add(id);
      }
    }

    print('actualIdsGroups: $actualIds');
    print('addedIdsGroups: $addedIds');
    print('removedIdsGroups: $removedIds');
  }

  void onAddDeleteGroup() async {
    try {
      _loading(true);
      await _personUseCase.updateRelationGroups(
          person!.id!, addedIds, removedIds);
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro',
        message: 'Não foi possivel atualizar este grupos',
        isError: true,
      );
    } finally {
      _personList.clear();
      _lastPage.value = false;
      _changePagination(1, 2);
      _loading(false);
      Get.back();
    }
  }

  void addDeleteLaw(PersonModel personModel) async {
    _person(personModel);

    actualIds.clear();
    addedIds.clear();
    removedIds.clear();
    List<LawModel> actual =
        await _personUseCase.readRelationLaws(personModel.id!);
    for (var element in actual) {
      actualIds.add(element.id!);
    }
    List<LawModel> all = await _lawUseCase.list();
    laws(all);
    Get.toNamed(Routes.personAddEditLaw);
  }

  void onAddDeletelaw() async {
    try {
      _loading(true);
      await _personUseCase.updateRelationLaws(
          person!.id!, addedIds, removedIds);
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro',
        message: 'Não foi possivel atualizar leis',
        isError: true,
      );
    } finally {
      _personList.clear();
      _lastPage.value = false;
      _changePagination(1, 2);
      _loading(false);
      Get.back();
    }
  }

  void addDeleteImage(PersonModel personModel) async {
    // var phraseTemp = _personList.firstWhere((element) => element.id == id);
    // _person(phraseTemp);
    _person(personModel);

    pickedXFile = null;
    croppedFile = null;
    List<PersonImageModel> images =
        await _personUseCase.readRelationImages(personModel.id!);
    personImageList(images);
    Get.toNamed(Routes.personAddEditImage);
  }

  Future<void> onAddImage({
    String mark = '',
  }) async {
    try {
      _loading(true);
      if (pickedXFile != null) {
        PersonImageModel personImageModel = PersonImageModel(
          person: person!,
        );
        String personImageId = await _personImageUseCase.add(personImageModel);
        String? personImageIdUrl;
        if (croppedFile != null) {
          personImageIdUrl = await XFileToParseFile.xFileToParseFile(
            nameOfFile: pickedXFile!.name,
            pathOfFile: croppedFile!.path,
            fileInListOfBytes: await croppedFile!.readAsBytes(),
            className: PersonImageEntity.className,
            objectId: personImageId,
            objectAttribute: 'photo',
          );
        } else if (pickedXFile != null) {
          personImageIdUrl = await XFileToParseFile.xFileToParseFile(
            nameOfFile: pickedXFile!.name,
            pathOfFile: pickedXFile!.path,
            fileInListOfBytes: await pickedXFile!.readAsBytes(),
            className: PersonImageEntity.className,
            objectId: personImageId,
            objectAttribute: 'photo',
          );
        }

        // String? personImageIdUrl = await XFileToParseFile.xFileToParseFile(
        //   xfile: pickedXFile!,
        //   className: PersonImageEntity.className,
        //   objectId: personImageId,
        //   objectAttribute: 'photo',
        // );
        pickedXFile = null;
        croppedFile = null;
        personImageModel = personImageModel.copyWith(
          id: personImageId,
          photo: personImageIdUrl,
          isDeleted: false,
        );
        // List<PersonImageModel> images = person!.images!;
        // PersonModel personModel = _person.value!.copyWith(images: images);
        // _person.refresh();
        await _personUseCase.updateRelationImages(
            person!.id!, personImageId, true);
        personImageList.add(personImageModel);
      }
    } on PersonImageRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar imagens',
        isError: true,
      );
    } finally {
      _personList.clear();
      _lastPage.value = false;
      _changePagination(1, 2);
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
      // List<PersonImageModel> images = [...person!.images!];
      // PersonImageModel model =
      //     personImageList.firstWhere((e) => e.id == objectImageId);
      // int id = personImageList.indexWhere((e) => e.id == objectImageId);
      //print('atualizando: ${model.id}');
      // PersonImageModel modelTemp = model.copyWith(isDeleted: true);
      // personImageList.fillRange(id, id + 1, modelTemp);
      // personImageList.removeWhere((e) => e.id == objectImageId);
      // personImageList.add(modelTemp);
      // PersonModel personModel = _person.value!.copyWith(images: images);
      // _person.update((val) {
      //   // val.images!.add(modelTemp);
      //   val!.images!.removeWhere((e) => e.id == objectImageId);
      // });
      // _person.refresh();

      // //print(person!.images!.length);
      // //print(_person.value!.images!.length);
      await _personUseCase.updateRelationImages(
          person!.id!, objectImageId, false);
      personImageList.removeWhere((e) => e.id == objectImageId);
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro',
        message: 'Não foi possivel apagar esta imagem',
        isError: true,
      );
    } finally {
      // await listAll();
      _loading(false);
      // Get.back();
    }
  }
}
