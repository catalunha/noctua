import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/view/controllers/operation/operation_controller.dart';
import 'package:noctua/app/view/pages/operation/parts/add_involved.dart';
import 'package:noctua/app/view/pages/utils/app_assets.dart';

class OperationInvolveds extends StatefulWidget {
  final OperationController operationController = Get.find();

  OperationInvolveds({Key? key}) : super(key: key);

  @override
  State<OperationInvolveds> createState() => _OperationInvolvedsState();
}

class _OperationInvolvedsState extends State<OperationInvolveds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar envolvidos para')),
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
              if (widget.operationController.operationIsUser())
                ElevatedButton(
                  child: Text(
                      'Adicionar envolvido aos ${widget.operationController.involvedsList.length} atuais'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AddInvolved(),
                    );
                  },
                ),
              const Divider(
                color: Colors.green,
              ),
              SingleChildScrollView(
                child: Column(children: [
                  ...widget.operationController.involvedsList
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

  Widget add(PersonModel personModel) {
    return ListTile(
      leading: personModel.photo != null && personModel.photo!.isNotEmpty
          ? Image.network(
              personModel.photo!,
              height: 50,
              width: 50,
            )
          : Image.asset(AppAssets.logo),
      title: Text(personModel.alias?.join(", ") ?? "Sem nome"),
      subtitle: Text(personModel.id!),
      trailing: widget.operationController.operationIsUser()
          ? IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () =>
                  widget.operationController.deleteInvolved(personModel.id!),
            )
          : null,
      onTap: () => widget.operationController.viewPersonData(personModel.id!),
    );
  }
}
