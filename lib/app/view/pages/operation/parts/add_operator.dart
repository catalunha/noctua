import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/operation/operation_controller.dart';
import 'package:noctua/app/view/pages/utils/app_textformfield.dart';
import 'package:validatorless/validatorless.dart';

class AddOperator extends StatefulWidget {
  final OperationController operationController = Get.find();

  AddOperator({
    Key? key,
  }) : super(key: key);

  @override
  State<AddOperator> createState() => _AddOperatorState();
}

class _AddOperatorState extends State<AddOperator> {
  final _formKey = GlobalKey<FormState>();
  final _emailTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    _emailTEC.text = '';
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
                const Text('Adicionar apenas um email do operador'),
                AppTextFormField(
                  label: 'Informe o email',
                  controller: _emailTEC,
                  validator: Validatorless.required('email é obrigatório'),
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
                            await widget.operationController.addOperator(
                              email: _emailTEC.text,
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
