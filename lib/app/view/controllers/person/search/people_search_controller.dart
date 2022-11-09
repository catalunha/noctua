import 'package:get/get.dart';
import 'package:noctua/app/data/b4a/entity/group_entity.dart';
import 'package:noctua/app/data/b4a/entity/law_entity.dart';
import 'package:noctua/app/data/b4a/entity/person_entity.dart';
import 'package:noctua/app/domain/models/group_model.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/domain/usecases/group/group_usecase.dart';
import 'package:noctua/app/domain/usecases/law/law_usecase.dart';
import 'package:noctua/app/domain/usecases/person/person_usecase.dart';
import 'package:noctua/app/domain/utils/pagination.dart';
import 'package:noctua/app/routes.dart';
import 'package:noctua/app/view/controllers/utils/loader_mixin.dart';
import 'package:noctua/app/view/controllers/utils/message_mixin.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PersonSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final PersonUseCase _personUseCase;
  final LawUseCase _lawUseCase;
  final GroupUseCase _groupUseCase;
  PersonSearchController({
    required PersonUseCase personUseCase,
    required LawUseCase lawUseCase,
    required GroupUseCase groupUseCase,
  })  : _personUseCase = personUseCase,
        _groupUseCase = groupUseCase,
        _lawUseCase = lawUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  List<PersonModel> personList = <PersonModel>[].obs;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  final Rxn<DateTime> _selectedDate = Rxn<DateTime>();
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? selectedDate1) {
    _selectedDate.value = selectedDate1;
  }

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));

  var groups = <GroupModel>[].obs;
  var laws = <LawModel>[].obs;

  @override
  void onInit() async {
    personList.clear();
    _changePagination(1, 2);
    ever(_pagination, (_) => listAll());
    loaderListener(_loading);
    messageListener(_message);
    await getGroups();
    await getLaws();
    super.onInit();
    // await countPeople();
  }

  Future<void> getGroups() async {
    List<GroupModel> all = await _groupUseCase.list();
    groups(all);
    print('getGroups');
    print(groups.map((e) => e.id!).toList());
  }

  Future<void> getLaws() async {
    List<LawModel> all = await _lawUseCase.list();
    laws(all);
    print('getLaws');
    print(laws.map((e) => e.id!).toList());
  }

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
  // Future<void> countPeople() async {
  //   print('PersonSearchController -> countPeople ${peopleCount.value}');
  // }

  Future<void> search({
    required bool aliasContainsBool,
    required String aliasContainsString,
    required bool aliasEqualToBool,
    required String aliasEqualToString,
    required bool nameContainsBool,
    required String nameContainsString,
    required bool nameEqualToBool,
    required String nameEqualToString,
    required bool cpfContainsBool,
    required String cpfContainsString,
    required bool cpfEqualToBool,
    required String cpfEqualToString,
    required bool motherContainsBool,
    required String motherContainsString,
    required bool motherEqualToBool,
    required String motherEqualToString,
    required bool markContainsBool,
    required String markContainsString,
    required bool markContains2Bool,
    required String markContains2String,
    required bool markContains3Bool,
    required String markContains3String,
    required bool birthdayBool,
    required bool groupEqualToBool,
    required GroupModel? groupSelected,
    required bool lawEqualToBool,
    required LawModel? lawSelected,
  }) async {
    _loading(true);
    personList.clear();
    // QueryBuilder<ParseObject> query =
    //     QueryBuilder<ParseObject>(ParseObject(PersonEntity.className));
    if (aliasContainsBool) {
      query.whereContains('alias', aliasContainsString);
    }
    if (aliasEqualToBool) {
      query.whereContainedIn('alias', [aliasEqualToString]);
    }
    if (nameContainsBool) {
      query.whereContains('name', nameContainsString);
    }
    if (nameEqualToBool) {
      query.whereEqualTo('name', nameEqualToString);
    }
    if (cpfContainsBool) {
      query.whereContains('cpf', cpfContainsString);
    }
    if (cpfEqualToBool) {
      query.whereEqualTo('cpf', cpfEqualToString);
    }
    if (motherContainsBool) {
      query.whereContains('mother', motherContainsString);
    }
    if (motherEqualToBool) {
      query.whereEqualTo('mother', motherEqualToString);
    }

    if (markContainsBool) {
      query.whereContains('mark', markContainsString);
    }
    if (markContains2Bool) {
      query.whereContains('mark', markContains2String);
    }
    if (markContains3Bool) {
      query.whereContains('mark', markContains3String);
    }
    if (birthdayBool) {
      selectedDate = selectedDate!.subtract(const Duration(hours: 3));
      query.whereEqualTo('birthday', selectedDate);
      selectedDate = selectedDate!.add(const Duration(hours: 3));
    }
    if (groupEqualToBool && groupSelected != null) {
      final parseObject = ParseObject(GroupEntity.className);
      parseObject.objectId = groupSelected.id;
      // query.whereEqualTo('groups', parseObject);
      query.whereContainedIn('groups', [parseObject]);
    }
    if (lawEqualToBool && lawSelected != null) {
      final parseObject = ParseObject(LawEntity.className);
      parseObject.objectId = lawSelected.id;
      // query.whereEqualTo('laws', parseObject);
      query.whereContainedIn('laws', [parseObject]);
    }
    // List<PersonModel> temp = await _personUseCase.list(query, Pagination());

    // personList.addAll([...temp]);
    listAll();
    _loading(false);
    Get.toNamed(Routes.personSearchResult);
  }

  listAll() async {
    _loading(true);

    List<PersonModel> temp =
        await _personUseCase.list(query, _pagination.value);
    if (temp.isEmpty) {
      _lastPage.value = true;
    }
    personList.addAll(temp);
    _loading(false);
  }
  /*

  Future<void> search({
    required bool aliasContainsBool,
    required String aliasContainsString,
    required bool aliasEqualToBool,
    required String aliasEqualToString,
    required bool nameContainsBool,
    required String nameContainsString,
    required bool nameEqualToBool,
    required String nameEqualToString,
    required bool cpfContainsBool,
    required String cpfContainsString,
    required bool cpfEqualToBool,
    required String cpfEqualToString,
    required bool motherContainsBool,
    required String motherContainsString,
    required bool motherEqualToBool,
    required String motherEqualToString,
    required bool markContainsBool,
    required String markContainsString,
    required bool markContains2Bool,
    required String markContains2String,
    required bool markContains3Bool,
    required String markContains3String,
  }) async {
    Isar? isar1 = Isar.getInstance();
    peopleList.clear();
    var peopleFiltered = <PersonModel>[];
    if (aliasContainsBool) {
      peopleFiltered.addAll(await isar1!.personModels
          .filter()
          .aliasElementContains(aliasContainsString)
          .findAll());
    }
    if (aliasEqualToBool) {
      peopleFiltered.addAll(await isar1!.personModels
          .filter()
          .aliasElementEqualTo(aliasEqualToString)
          .findAll());
    }
    if (nameContainsBool) {
      peopleFiltered.addAll(await isar1!.personModels
          .filter()
          .nameContains(nameContainsString)
          .findAll());
    }
    if (nameEqualToBool) {
      peopleFiltered.addAll(await isar1!.personModels
          .filter()
          .nameEqualTo(nameEqualToString)
          .findAll());
    }
    if (cpfContainsBool) {
      peopleFiltered.addAll(await isar1!.personModels
          .filter()
          .cpfContains(cpfContainsString)
          .findAll());
    }
    if (cpfEqualToBool) {
      peopleFiltered.addAll(await isar1!.personModels
          .filter()
          .cpfEqualTo(cpfEqualToString)
          .findAll());
    }
    if (motherContainsBool) {
      peopleFiltered.addAll(await isar1!.personModels
          .filter()
          .motherContains(motherContainsString)
          .findAll());
    }
    if (motherEqualToBool) {
      peopleFiltered.addAll(await isar1!.personModels
          .filter()
          .motherEqualTo(motherEqualToString)
          .findAll());
    }

    // if (markContainsBool) {
    //   peopleFiltered.addAll(await isar1!.personModels
    //       .filter()
    //       .marksContains(markContainsString)
    //       .findAll());
    // }
    // if (markContains2Bool) {
    //   peopleFiltered.addAll(await isar1!.personModels
    //       .filter()
    //       .marksContains(markContains2String)
    //       .findAll());
    // }
    // if (markContains3Bool) {
    //   peopleFiltered.addAll(await isar1!.personModels
    //       .filter()
    //       .marksContains(markContains3String)
    //       .findAll());
    // }

    // peopleFiltered.addAll(await isar1!.personModels
    //     .filter()
    //     .marksContains(markContainsString)
    //     .marksContains(markContains2String)
    //     .marksContains(markContains3String)
    //     .findAll());

    var peopleFilter = isar1!.personModels.filter();

    QueryBuilder<PersonModel, PersonModel, QAfterFilterCondition> a;
    a = peopleFilter.marksIsNotEmpty();
    a = a.marksContains(markContainsString);
    a = a.marksContains(markContains2String);
    a = a.marksContains(markContains3String);
    // a.marksContains(markContains2String);
    // peopleFiltered.addAll(
    //     await peopleFilter.marksContains(markContains3String).findAll());
    // peopleFilter = peopleFilter.marksContains(markContains3String);
    // peopleFilter = await isar1.personModels.filter().peopleFilter.findAll();
    peopleFiltered.addAll(await a.findAll());
    // peopleFiltered.addAll(peopleFilter.findAll());

    // peopleFiltered =
    //     await isar1!.personModels.where().limit(25).findAll();
    peopleList.addAll(peopleFiltered);
    print('PeopleController -> peopleList ${peopleList.length}');
    Get.toNamed(Routes.people);
  }
  */
}
