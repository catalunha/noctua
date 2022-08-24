import 'package:get/get.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/usecases/person/person_filter.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
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
}
