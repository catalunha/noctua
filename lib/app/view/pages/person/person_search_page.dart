import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/domain/models/group_model.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/view/controllers/person/search/people_search_controller.dart';
import 'package:noctua/app/view/pages/person/parts/calendar2_button.dart';
import 'package:noctua/app/view/pages/utils/app_dropdown_generic.dart';
import 'package:noctua/app/view/pages/utils/app_icon.dart';
import 'package:noctua/app/view/pages/utils/app_textformfield.dart';

class PersonSearchPage extends StatefulWidget {
  PersonSearchController personSearchController = Get.find();
  PersonSearchPage({Key? key}) : super(key: key);

  @override
  State<PersonSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<PersonSearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _nameContains = false;
  bool _nameEqualTo = false;
  bool _aliasContains = false;
  bool _aliasEqualTo = false;
  bool _cpfContains = false;
  bool _cpfEqualTo = false;
  bool _motherContains = false;
  bool _motherEqualTo = false;
  bool _markContains = false;
  bool _markContains2 = false;
  bool _markContains3 = false;
  bool _birthday = false;
  bool _lawEqualTo = false;
  bool _groupEqualTo = false;
  final _aliasContainsTEC = TextEditingController();
  final _aliasEqualToTEC = TextEditingController();
  final _nameContainsTEC = TextEditingController();
  final _nameEqualToTEC = TextEditingController();
  final _cpfContainsTEC = TextEditingController();
  final _cpfEqualToTEC = TextEditingController();
  final _motherContainsTEC = TextEditingController();
  final _motherEqualToTEC = TextEditingController();
  final _markContainsTEC = TextEditingController();
  final _markContains2TEC = TextEditingController();
  final _markContains3TEC = TextEditingController();
  LawModel? lawSelected;
  GroupModel? groupSelected;

  @override
  void initState() {
    _aliasContainsTEC.text = '';
    _aliasEqualToTEC.text = '';
    _nameContainsTEC.text = '';
    _nameEqualToTEC.text = '';
    _cpfContainsTEC.text = '';
    _cpfEqualToTEC.text = '';
    _motherContainsTEC.text = '';
    _motherEqualToTEC.text = '';
    _markContainsTEC.text = '';
    _markContains2TEC.text = '';
    _markContains3TEC.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscando registro'),
        // 'Buscando em ${widget.personSearchController.peopleCount} registros')),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    const Text('campo APELIDO'),
                    Row(
                      children: [
                        Checkbox(
                          value: _aliasContains,
                          onChanged: (value) {
                            setState(() {
                              _aliasContains = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'Apelido que contém',
                            controller: _aliasContainsTEC,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _aliasEqualTo,
                          onChanged: (value) {
                            setState(() {
                              _aliasEqualTo = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'Apelido igual a',
                            controller: _aliasEqualToTEC,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('campo NOME'),
                    Row(
                      children: [
                        Checkbox(
                          value: _nameContains,
                          onChanged: (value) {
                            setState(() {
                              _nameContains = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'Nome que contém',
                            controller: _nameContainsTEC,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _nameEqualTo,
                          onChanged: (value) {
                            setState(() {
                              _nameEqualTo = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'Nome igual a',
                            controller: _nameEqualToTEC,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('campo CPF'),
                    Row(
                      children: [
                        Checkbox(
                          value: _cpfContains,
                          onChanged: (value) {
                            setState(() {
                              _cpfContains = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'CPF que contém',
                            controller: _cpfContainsTEC,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _cpfEqualTo,
                          onChanged: (value) {
                            setState(() {
                              _cpfEqualTo = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'CPF igual a',
                            controller: _cpfEqualToTEC,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('campo MÃE'),
                    Row(
                      children: [
                        Checkbox(
                          value: _motherContains,
                          onChanged: (value) {
                            setState(() {
                              _motherContains = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'Mãe que contém',
                            controller: _motherContainsTEC,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _motherEqualTo,
                          onChanged: (value) {
                            setState(() {
                              _motherEqualTo = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'Mãe igual a',
                            controller: _motherEqualToTEC,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('campo CARACTERISTICAS'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Checkbox(
                          value: _markContains,
                          onChanged: (value) {
                            setState(() {
                              _markContains = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'Característica 1 que contém',
                            controller: _markContainsTEC,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _markContains2,
                          onChanged: (value) {
                            setState(() {
                              _markContains2 = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'Característica 2 que contém',
                            controller: _markContains2TEC,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _markContains3,
                          onChanged: (value) {
                            setState(() {
                              _markContains3 = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextFormField(
                            label: 'Característica 3 que contém',
                            controller: _markContains3TEC,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('campo Data de nascimento'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Checkbox(
                          value: _birthday,
                          onChanged: (value) {
                            setState(() {
                              _birthday = value!;
                            });
                          },
                        ),
                        Calendar2Button(),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('campo Grupo'),
                    Row(
                      children: [
                        Checkbox(
                          value: _groupEqualTo,
                          onChanged: (value) {
                            setState(() {
                              _groupEqualTo = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Obx(() => AppDropDownGeneric<GroupModel>(
                                options: widget.personSearchController.groups
                                    .toList(),
                                selected: groupSelected,
                                execute: (value) {
                                  groupSelected = value;
                                  setState(() {});
                                },
                                width: 150,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('campo Lei'),
                    Row(
                      children: [
                        Checkbox(
                          value: _lawEqualTo,
                          onChanged: (value) {
                            setState(() {
                              _lawEqualTo = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Obx(() => AppDropDownGeneric<LawModel>(
                                options:
                                    widget.personSearchController.laws.toList(),
                                selected: lawSelected,
                                execute: (value) {
                                  lawSelected = value;
                                  setState(() {});
                                },
                                width: 150,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Executar busca',
        child: const Icon(AppIconData.search),
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget.personSearchController.search(
              aliasContainsBool: _aliasContains,
              aliasContainsString: _aliasContainsTEC.text,
              aliasEqualToBool: _aliasEqualTo,
              aliasEqualToString: _aliasEqualToTEC.text,
              nameContainsBool: _nameContains,
              nameContainsString: _nameContainsTEC.text,
              nameEqualToBool: _nameEqualTo,
              nameEqualToString: _nameEqualToTEC.text,
              cpfContainsBool: _cpfContains,
              cpfContainsString: _cpfContainsTEC.text,
              cpfEqualToBool: _cpfEqualTo,
              cpfEqualToString: _cpfEqualToTEC.text,
              motherContainsBool: _motherContains,
              motherContainsString: _motherContainsTEC.text,
              motherEqualToBool: _motherEqualTo,
              motherEqualToString: _motherEqualToTEC.text,
              markContainsBool: _markContains,
              markContainsString: _markContainsTEC.text,
              markContains2Bool: _markContains2,
              markContains2String: _markContains2TEC.text,
              markContains3Bool: _markContains3,
              markContains3String: _markContains3TEC.text,
              birthdayBool: _birthday,
              groupEqualToBool: _groupEqualTo,
              groupSelected: groupSelected,
              lawEqualToBool: _lawEqualTo,
              lawSelected: lawSelected,
            );
            // Get.back();
          }
        },
      ),
    );
  }
}
