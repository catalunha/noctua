import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/domain/models/operation_model.dart';
import 'package:noctua/app/view/controllers/operation/operation_controller.dart';

class OperationCard extends StatelessWidget {
  final OperationController _personController = Get.find();

  final OperationModel operationModel;
  OperationCard({Key? key, required this.operationModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(operationModel.name),
            subtitle: Text(operationModel.boss!),
          ),
          Wrap(
            children: [
              IconButton(
                onPressed: () => _personController.edit(operationModel.id!),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () =>
                    _personController.getOperatorsList(operationModel.id!),
                icon: const Icon(Icons.people),
              ),
              IconButton(
                onPressed: () =>
                    _personController.getInvolvedsList(operationModel.id!),
                icon: const Icon(Icons.people_outline),
              ),

              // IconButton(
              //   onPressed: () =>
              //       _personController.addDeleteLaw(operationModel.id!),
              //   icon: const Icon(Icons.crop_sharp),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
