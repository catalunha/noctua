import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/domain/models/group_model.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/utils/app_icon.dart';
import 'package:noctua/app/view/pages/utils/app_theme.dart';

class PersonAddEditGroup extends StatefulWidget {
  final PersonController _personController = Get.find();

  PersonAddEditGroup({Key? key}) : super(key: key);

  @override
  State<PersonAddEditGroup> createState() => _PersonAddEditGroupState();
}

class _PersonAddEditGroupState extends State<PersonAddEditGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar grupos para')),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Pessoa com apelido:'),
                Text(
                  widget._personController.person?.alias?.join(", ") ?? "...",
                  style: AppTheme.textRed18Bold,
                ),
                const SizedBox(height: 5),
                Text(
                    'Em Grupos ${widget._personController.groups.length} atuais:'),
                ...widget._personController.groups
                    .map((e) => groupWidget(e))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget._personController.onAddDeleteGroup();
        },
        child: const Icon(AppIconData.saveInCloud),
      ),
    );
  }

  Widget groupWidget(GroupModel group) {
    return Obx(() => ListTile(
          tileColor: (widget._personController.actualIds.contains(group.id) ||
                      widget._personController.addedIds.contains(group.id)) &&
                  !widget._personController.removedIds.contains(group.id)
              ? Colors.blueAccent
              : null,
          title: Text(group.name),
          subtitle: Text(group.description ?? "..."),
          trailing: IconButton(
            onPressed: () {
              widget._personController.onUpdateGroupIdInList(group.id!);
            },
            icon: (widget._personController.actualIds.contains(group.id) ||
                        widget._personController.addedIds.contains(group.id)) &&
                    !widget._personController.removedIds.contains(group.id)
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank),
          ),
        ));
  }
}
