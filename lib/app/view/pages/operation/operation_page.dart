import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/operation/operation_controller.dart';
import 'package:noctua/app/view/pages/operation/parts/operation_list.dart';

class OperationPage extends StatelessWidget {
  OperationController operationController = Get.find();
  OperationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listando operações'),
      ),
      body: Column(children: [
        SingleChildScrollView(child: OperationList()),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => operationController.add(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
