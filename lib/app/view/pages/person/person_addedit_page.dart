import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/person/parts/calendar_button.dart';
import 'package:noctua/app/view/pages/person/parts/image_view_add.dart';
import 'package:noctua/app/view/pages/utils/app_icon.dart';
import 'package:noctua/app/view/pages/utils/app_textformfield.dart';
import 'package:validatorless/validatorless.dart';

class PhraseAddEditPage extends StatefulWidget {
  final PersonController _personController = Get.find();

  PhraseAddEditPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PhraseAddEditPage> createState() => _PhraseAddEditPageState();
}

class _PhraseAddEditPageState extends State<PhraseAddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameTEC = TextEditingController();
  final _cpfTEC = TextEditingController();
  final _historyTEC = TextEditingController();
  final _markTEC = TextEditingController();
  final _motherTEC = TextEditingController();
  final _aliasTEC = TextEditingController();
  bool _isMale = true;
  bool _isArchived = false;
  bool _isPublic = false;
  bool _isDeleted = false;
  @override
  void initState() {
    super.initState();
    _nameTEC.text = widget._personController.person?.name ?? '';
    _cpfTEC.text = widget._personController.person?.cpf ?? '';
    _historyTEC.text = widget._personController.person?.history ?? '';
    _motherTEC.text = widget._personController.person?.mother ?? '';
    _aliasTEC.text = widget._personController.person?.alias?.join(', ') ?? '';
    _markTEC.text = widget._personController.person?.marks ?? '';
    _isMale = widget._personController.person?.isFemale ?? true;
    _isArchived = widget._personController.person?.isArchived ?? false;
    _isPublic = widget._personController.person?.isPublic ?? false;
    _isDeleted = widget._personController.person?.isDeleted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._personController.person == null
            ? 'Adicionar uma pessoa'
            : 'Editar esta pessoa'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                AppTextFormField(
                  label: 'Apelidos. Separe por virgula. Ex.: a, b',
                  controller: _aliasTEC,
                  validator: Validatorless.required('Este campo é requerido.'),
                ),
                AppTextFormField(
                  label: 'Nome completo',
                  controller: _nameTEC,
                ),
                AppTextFormField(
                  label: 'CPF. Apenas números',
                  controller: _cpfTEC,
                  validator: Validatorless.cpf('Número não é CPF válido'),
                ),
                AppTextFormField(
                  label: 'Nome completo da mãe',
                  controller: _motherTEC,
                ),
                AppTextFormField(
                  label: 'Características',
                  controller: _markTEC,
                  maxLines: 5,
                ),
                AppTextFormField(
                  label: 'Histórico',
                  controller: _historyTEC,
                  maxLines: 5,
                ),
                // Row(
                //   children: [
                // PersonPhoto(photo: widget._personController.person?.photo),
                ImageViewAdd(
                  pickedXFile: widget._personController.pickedXFile,
                  croppedFile: widget._personController.croppedFile,
                  photoActual: widget._personController.person?.photo,
                  setPickedXFile: (value) {
                    widget._personController.setPickedXFile(value);
                    setState(() {});
                  },
                  setCroppedFile: (value) {
                    widget._personController.setCroppedFile(value);
                    setState(() {});
                  },
                ),
                // ViewPhoto(
                //   pickedFile: widget._personController.pickedXFile,
                //   croppedFile: widget._personController.croppedFile,
                //   photoActual: widget._personController.person?.photo,
                // ),
                // IconButton(
                //   icon: const Icon(Icons.image),
                //   onPressed: () async {
                //     // Get.toNamed(Routes.personAddPhoto);
                //     await Get.to(
                //       () => ImageGetCrop(
                //         pickedFile: widget._personController.pickedXFile,
                //         croppedFile: widget._personController.croppedFile,
                //         setPickedXFile: (value) =>
                //             widget._personController.setPickedXFile(value),
                //         setCroppedFile: (value) {
                //           widget._personController.setCroppedFile(value);
                //         },
                //       ),
                //     );
                //     // print(widget._personController.pickedXFile!.path);
                //     setState(() {});
                //   },
                // ),
                CheckboxListTile(
                  title: const Text("É homem ?"),
                  onChanged: (value) {
                    setState(() {
                      _isMale = value!;
                    });
                  },
                  value: _isMale,
                ),
                //   ],
                // ),
                const SizedBox(
                  height: 5,
                ),
                CalendarButton(),
                CheckboxListTile(
                  title: const Text("Esta pessoa é pública"),
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                  value: _isPublic,
                ),
                CheckboxListTile(
                  title: const Text("Arquivar esta pessoa"),
                  onChanged: (value) {
                    setState(() {
                      _isArchived = value!;
                    });
                  },
                  value: _isArchived,
                ),
                widget._personController.person == null
                    ? Container()
                    : CheckboxListTile(
                        tileColor: _isDeleted ? Colors.red : null,
                        title: const Text("Apagar esta pessoa"),
                        onChanged: (value) {
                          setState(() {
                            _isDeleted = value!;
                          });
                        },
                        value: _isDeleted,
                      ),
                const SizedBox(height: 120),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Salvar estes campos em núvem',
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._personController.addedit(
              isFemale: _isMale,
              name: _nameTEC.text,
              cpf: _cpfTEC.text,
              alias: _aliasTEC.text,
              mother: _motherTEC.text,
              mark: _markTEC.text,
              history: _historyTEC.text,
              isPublic: _isPublic,
              isArchived: _isArchived,
              isDeleted: _isDeleted,
            );
            Get.back();
          }
        },
      ),
    );
  }
}
