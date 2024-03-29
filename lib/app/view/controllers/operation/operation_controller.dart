import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/entity/operation_entity.dart';
import 'package:noctua/app/data/b4a/operation/operation_repository_exception.dart';
import 'package:noctua/app/data/b4a/user/user/user_repository_exception.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/operation_model.dart';
import 'package:noctua/app/domain/models/person_image_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/models/user_model.dart';
import 'package:noctua/app/domain/usecases/operation/operation_usecase.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
import 'package:noctua/app/domain/usecases/user/user/user_usecase.dart';
import 'package:noctua/app/routes.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:noctua/app/view/controllers/utils/loader_mixin.dart';
import 'package:noctua/app/view/controllers/utils/message_mixin.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class OperationController extends GetxController
    with LoaderMixin, MessageMixin {
  final OperationUsecase _operationUsecase;
  final UserUseCase _userUseCase;
  final PersonUseCase _personUseCase;

  OperationController({
    required OperationUsecase operationUseCase,
    required UserUseCase userUseCase,
    required PersonUseCase personUseCase,
  })  : _operationUsecase = operationUseCase,
        _userUseCase = userUseCase,
        _personUseCase = personUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final operationList = <OperationModel>[].obs;
  final operatorsList = <UserModel>[].obs;
  final involvedsList = <PersonModel>[].obs;
  final _operation = Rxn<OperationModel>();
  OperationModel? get operation => _operation.value;
  set operation(OperationModel? operationModel) =>
      _operation.value = operationModel;
  @override
  void onReady() {
    super.onReady();
    listAll();
  }

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  void listAll() async {
    _loading(true);
    operationList.clear();
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(OperationEntity.className));
    List<OperationModel> temp = await _operationUsecase.list();
    operationList.addAll([...temp]);
    print('listAll: ${operationList.length}');
    _loading(false);
  }

  void add() {
    operation = null;
    Get.toNamed(Routes.operationAddEdit);
  }

  void edit(String id) {
    var phraseTemp = operationList.firstWhere((element) => element.id == id);
    operation = phraseTemp;
    Get.toNamed(Routes.operationAddEdit);
  }

  Future<void> addedit({
    String name = '',
    String boss = '',
    String history = '',
    bool isDeleted = false,
  }) async {
    try {
      _loading(true);
      UserModel userModel;
      String? modelId;
      if (operation == null) {
        SplashController splashController = Get.find();
        userModel = splashController.userModel!;
      } else {
        userModel = operation!.organizer;
        modelId = operation!.id;
      }

      OperationModel model = OperationModel(
        id: modelId,
        organizer: userModel,
        name: name,
        boss: boss,
        history: history,
        isDeleted: isDeleted,
      );
      String operationId = await _operationUsecase.addEdit(model);
      OperationModel modelFinal = model.copyWith(id: operationId);

      int index = operationList.indexWhere((e) => e.id == operationId);
      if (index >= 0) operationList.fillRange(index, index + 1, modelFinal);
    } on OperationRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar os dados',
        isError: true,
      );
    } finally {
      _loading(false);
      Get.back();
    }
  }

  bool operationIsUser() {
    SplashController splashController = Get.find();
    UserModel userModel = splashController.userModel!;
    return operation!.organizer == userModel;
  }

  void getOperatorsList(String id) async {
    var phraseTemp = operationList.firstWhere((element) => element.id == id);
    operation = phraseTemp;
    operatorsList.clear();
    print('id: $id');
    var allOperators = await _operationUsecase.readRelationOperators(id);
    operatorsList.addAll([...allOperators]);
    print('operatorsList: ${operatorsList.length}');
    Get.toNamed(Routes.operationOperators);
  }

  addOperator({required String email}) async {
    try {
      Get.back();
      _loading(true);
      print('buscando $email');
      UserModel? person = await _userUseCase.readByEmail(email);
      if (person != null) {
        print('pessoa encontrada ${person.id}');
        await _operationUsecase.updateRelationOperators(
            operation!.id!, [person.id], true);
        // operatorsList.add(person);
      } else {
        print('nao achei nenhuma pessoa com este email');
        throw Exception();
      }
    } on UserRepositoryException catch (e) {
      _loading(false);

      _message.value = MessageModel(
        title: 'Oops em User',
        message: e.message,
        isError: true,
      );
    } on OperationRepositoryException catch (e) {
      _loading(false);

      _message.value = MessageModel(
        title: 'Oops em operation',
        message: e.message,
        isError: true,
      );
    } catch (e) {
      // Get.back();
      print('catch');
      _loading(false);
      print(e);
      _message.value = MessageModel(
        title: 'Oops',
        message: 'Nao achei nenhuma pessoa com este email',
        isError: true,
      );
    } finally {
      getOperatorsList(operation!.id!);
      _loading(false);
    }
  }

  deleteOperator(String operatorId) async {
    try {
      _loading(true);
      operatorsList.removeWhere((e) => e.id == operatorId);
      await _operationUsecase.updateRelationOperators(
          operation!.id!, [operatorId], false);
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro',
        message: 'Não foi possivel apagar este operador',
        isError: true,
      );
    } finally {
      getOperatorsList(operation!.id!);
      _loading(false);
    }
  }

  void getInvolvedsList(String id) async {
    var phraseTemp = operationList.firstWhere((element) => element.id == id);
    operation = phraseTemp;
    involvedsList.clear();
    var all = await _operationUsecase.readRelationInvolveds(id);
    involvedsList.addAll([...all]);
    print('involvedsList: ${involvedsList.length}');
    Get.toNamed(Routes.operationInvolveds);
  }

  addInvolved({required String id}) async {
    try {
      Get.back();
      _loading(true);
      print('buscando $id');
      PersonModel? person = await _personUseCase.read(id);
      if (person != null) {
        print('pessoa encontrada ${person.id}');
        await _operationUsecase.updateRelationInvolveds(
            operation!.id!, [person.id!], true);
        // operatorsList.add(person);
      } else {
        print('nao achei nenhuma pessoa com este id');
        throw Exception();
      }
    } on UserRepositoryException catch (e) {
      _loading(false);

      _message.value = MessageModel(
        title: 'Oops em User',
        message: e.message,
        isError: true,
      );
    } on OperationRepositoryException catch (e) {
      _loading(false);

      _message.value = MessageModel(
        title: 'Oops em operation',
        message: e.message,
        isError: true,
      );
    } catch (e) {
      // Get.back();
      print('catch');
      _loading(false);
      print(e);
      _message.value = MessageModel(
        title: 'Oops',
        message: 'Nao achei nenhuma pessoa com este id',
        isError: true,
      );
    } finally {
      getInvolvedsList(operation!.id!);
      _loading(false);
    }
  }

  deleteInvolved(String personId) async {
    try {
      _loading(true);
      operatorsList.removeWhere((e) => e.id == personId);
      await _operationUsecase.updateRelationInvolveds(
          operation!.id!, [personId], false);
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro',
        message: 'Não foi possivel apagar este envolvido',
        isError: true,
      );
    } finally {
      getInvolvedsList(operation!.id!);
      _loading(false);
    }
  }

  void viewPersonData(String id) async {
    PersonModel? person = await _personUseCase.read(id);
    List<PersonImageModel> images = await _personUseCase.readRelationImages(id);
    List<LawModel> laws = await _personUseCase.readRelationLaws(id);
    var person2 = person!.copyWith(images: images, laws: laws);
    Get.toNamed(Routes.personData, arguments: person2);
  }
}
