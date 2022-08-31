import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/utils/app_assets.dart';

class PersonCard extends StatelessWidget {
  final PersonController _personController = Get.find();

  final PersonModel personModel;
  PersonCard({Key? key, required this.personModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: personModel.photo != null && personModel.photo!.isNotEmpty
                ? Image.network(
                    personModel.photo!,
                    height: 50,
                    width: 50,
                  )
                : Image.asset(AppAssets.logo),
            title: Text(personModel.alias?.join(", ") ?? "Sem nome"),
            subtitle: Text(personModel.id!),
          ),
          Wrap(
            children: [
              IconButton(
                onPressed: () => _personController.edit(personModel.id!),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => _personController.viewData(personModel.id!),
                icon: const Icon(Icons.art_track),
              ),
              IconButton(
                onPressed: () =>
                    _personController.addEditImage(personModel.id!),
                icon: const Icon(Icons.photo_library_rounded),
              ),
            ],
          )
        ],
      ),
    );
  }
}
