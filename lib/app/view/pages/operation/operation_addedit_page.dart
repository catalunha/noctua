import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/operation/operation_controller.dart';
import 'package:noctua/app/view/pages/utils/app_icon.dart';
import 'package:noctua/app/view/pages/utils/app_textformfield.dart';
import 'package:validatorless/validatorless.dart';

class OperationAddEditPage extends StatefulWidget {
  final OperationController operationController = Get.find();

  OperationAddEditPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OperationAddEditPage> createState() => _OperationAddEditPageState();
}

class _OperationAddEditPageState extends State<OperationAddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameTEC = TextEditingController();
  final _bossTEC = TextEditingController();
  final _historyTEC = TextEditingController();
  bool _isDeleted = false;
  @override
  void initState() {
    super.initState();
    _nameTEC.text = widget.operationController.operation?.name ?? '';
    _bossTEC.text = widget.operationController.operation?.boss ?? '';
    _historyTEC.text = widget.operationController.operation?.history ?? '';
    _isDeleted = widget.operationController.operation?.isDeleted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.operationController.operation == null
            ? 'Adicionar uma operação'
            : 'Editar esta operação'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                AppTextFormField(
                  label: 'Nome da operação',
                  controller: _nameTEC,
                  validator: Validatorless.required('Este campo é requerido.'),
                ),
                AppTextFormField(
                  label: 'Lider da operação',
                  controller: _bossTEC,
                ),
                AppTextFormField(
                  label: 'Histórico',
                  controller: _historyTEC,
                  maxLines: 5,
                ),
                widget.operationController.operation == null
                    ? Container()
                    : CheckboxListTile(
                        tileColor: _isDeleted ? Colors.red : null,
                        title: const Text("Apagar esta operação"),
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
            await widget.operationController.addedit(
              name: _nameTEC.text,
              boss: _bossTEC.text,
              history: _historyTEC.text,
              isDeleted: _isDeleted,
            );
            Get.back();
          }
        },
      ),
    );
  }
}
