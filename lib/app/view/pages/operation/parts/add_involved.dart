import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/operation/operation_controller.dart';
import 'package:noctua/app/view/pages/utils/app_textformfield.dart';
import 'package:validatorless/validatorless.dart';

class AddInvolved extends StatefulWidget {
  final OperationController operationController = Get.find();

  AddInvolved({
    Key? key,
  }) : super(key: key);

  @override
  State<AddInvolved> createState() => _AddInvolvedState();
}

class _AddInvolvedState extends State<AddInvolved> {
  final _formKey = GlobalKey<FormState>();
  final _objectIdTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    _objectIdTEC.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Adicionar apenas um id de envolvido'),
                AppTextFormField(
                  label: 'Informe um id',
                  controller: _objectIdTEC,
                  validator: Validatorless.required('id é obrigatório'),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar')),
                    const SizedBox(
                      width: 50,
                    ),
                    TextButton(
                        onPressed: () async {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            await widget.operationController.addInvolved(
                              id: _objectIdTEC.text,
                            );
                          }
                        },
                        child: const Text('Buscar')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
