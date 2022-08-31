import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/domain/models/law_model.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/utils/app_icon.dart';
import 'package:noctua/app/view/pages/utils/app_theme.dart';

class PersonAddEditLaw extends StatefulWidget {
  final PersonController _personController = Get.find();

  PersonAddEditLaw({Key? key}) : super(key: key);

  @override
  State<PersonAddEditLaw> createState() => _PersonAddEditLawState();
}

class _PersonAddEditLawState extends State<PersonAddEditLaw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar leis para')),
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
                    'Leis (${widget._personController.lawIdSelectedList.length}):'),
                ...widget._personController.lawList.map((e) => law(e)).toList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget._personController.onAddEditlaw();
        },
        child: const Icon(AppIconData.saveInCloud),
      ),
    );
  }

  Widget law(LawModel law) {
    return ListTile(
      tileColor: widget._personController.lawIdSelectedList.contains(law.id)
          ? Colors.blueAccent
          : null,
      title: Text(law.name),
      subtitle: Text(law.note ?? "..."),
      trailing: IconButton(
        onPressed: () {
          widget._personController.onUpdateLawIdSelectedList(law.id!);
        },
        icon: widget._personController.lawIdSelectedList.contains(law.id)
            ? const Icon(Icons.check_box)
            : const Icon(Icons.check_box_outline_blank),
      ),
    );
  }
}
