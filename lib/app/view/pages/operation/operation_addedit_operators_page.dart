import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/domain/models/user_model.dart';
import 'package:noctua/app/view/controllers/operation/operation_controller.dart';
import 'package:noctua/app/view/pages/operation/parts/add_operator.dart';

class OperationAddEditOperators extends StatefulWidget {
  final OperationController operationController = Get.find();

  OperationAddEditOperators({Key? key}) : super(key: key);

  @override
  State<OperationAddEditOperators> createState() =>
      _OperationAddEditOperatorsState();
}

class _OperationAddEditOperatorsState extends State<OperationAddEditOperators> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar operadores para')),
      body: Center(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text(widget.operationController.operation!.name),
                subtitle:
                    Text(widget.operationController.operation!.boss ?? '...'),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                child: const Text('Adicionar operador'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AddOperator(),
                  );
                },
              ),
              Text(
                  'Operadores atuais (${widget.operationController.operatorsList.length}):'),
              SingleChildScrollView(
                child: Column(children: [
                  ...widget.operationController.operatorsList
                      .map((e) => add(e))
                      .toList()
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget add(UserModel user) {
    return ListTile(
        title: Text(user.profile!.name ?? '...'),
        subtitle: Text(user.profile!.unit ?? '...'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: () => widget.operationController.deleteOperator(user.id),
        ));
  }
}
