import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';

class PersonCard extends StatelessWidget {
  final PersonController _personController = Get.find();

  final PersonModel personModel;
  PersonCard({Key? key, required this.personModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return Card(
      child: Column(
        children: [
          // ListTile(
          //   leading: personModel.photo != null && personModel.photo!.isNotEmpty
          //       ? Image.network(
          //           personModel.photo!,
          //           height: 50,
          //           width: 50,
          //         )
          //       : Image.asset(AppAssets.logo),
          //   title: Text(personModel.alias?.join(", ") ?? "Sem nome"),
          //   subtitle: Text(personModel.id!),
          // ),
          Row(
            children: [
              personModel.photo != null && personModel.photo!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        personModel.photo!,
                        height: 58,
                        width: 58,
                      ),
                    )
                  : const SizedBox(
                      height: 58, width: 58, child: Icon(Icons.warning)),
              // e.photoByte != null && e.photoByte!.isNotEmpty
              //     ? Image.memory(
              //         Uint8List.fromList(e.photoByte!),
              //         width: 75,
              //         height: 75,
              //         // fit: BoxFit.contain,
              //       )
              //     : const Text('...'),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome: ${personModel.name}'),
                    Text('Alias: ${personModel.alias?.join(",")}'),
                    Text('Mae: ${personModel.mother}'),
                    Text('CPF: ${personModel.cpf}'),
                    Text('Marcas: ${personModel.marks}'),
                    // Text('DataNasc: ${e.birthday?.toIso8601String()}'),
                    Text(
                        'DataNasc: ${personModel.birthday != null ? formatter.format(personModel.birthday!) : "..."}'),
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              IconButton(
                onPressed: () => copy(personModel.id!),
                icon: const Icon(Icons.copy),
              ),
              IconButton(
                onPressed: () => _personController.edit(personModel),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => _personController.viewData(personModel),
                icon: const Icon(Icons.art_track),
              ),
              IconButton(
                onPressed: () => _personController.addDeleteGroup(personModel),
                icon: const Icon(Icons.groups),
              ),
              IconButton(
                onPressed: () => _personController.addDeleteLaw(personModel),
                icon: const Icon(Icons.crop_sharp),
              ),
              IconButton(
                onPressed: () => _personController.addDeleteImage(personModel),
                icon: const Icon(Icons.photo_library_rounded),
              ),
            ],
          )
        ],
      ),
    );
  }

  copy(String text) async {
    Get.snackbar(
      text,
      'Id copiado.',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
    );
    await Clipboard.setData(ClipboardData(text: text));
  }
}
