import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/operation/operation_controller.dart';
import 'package:noctua/app/view/pages/operation/parts/operation_card.dart';

class OperationList extends StatelessWidget {
  final OperationController operationController = Get.find();

  OperationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: personList()));
  }

  List<Widget> personList() {
    List<Widget> list = [];
    list.addAll(operationController.operationList
        .map((e) => OperationCard(operationModel: e))
        .toList());
    return list;
  }
}
