import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noctua/app/view/controllers/person/search/people_search_controller.dart';

class PersonSearchResultPage extends StatelessWidget {
  final PersonSearchController personSearchController = Get.find();
  PersonSearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            'Encontrei ${personSearchController.personList.length} pessoas')),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Center(
              child: Column(
                children: buildPeople(context),
              ),
            ),
          )),
    );
  }

  List<Widget> buildPeople(context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');

    List<Widget> list = [];
    for (var e in personSearchController.personList) {
      list.add(Card(
        child: Row(
          children: [
            e.photo != null && e.photo!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      e.photo!,
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
                  Text('Nome: ${e.name}'),
                  Text('Alias: ${e.alias?.join(",")}'),
                  Text('Mae: ${e.mother}'),
                  Text('CPF: ${e.cpf}'),
                  Text('Marcas: ${e.mark}'),
                  Text('DataNasc: ${e.birthday}'),
                  Text(
                      'DataNasc: ${e.birthday != null ? formatter.format(e.birthday!) : "..."}'),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return list;
  }
}