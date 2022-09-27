import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noctua/app/view/controllers/person/search/people_search_controller.dart';
import 'package:noctua/app/view/pages/person/parts/person_card.dart';
import 'package:noctua/app/view/pages/person/parts/person_list2.dart';

class PersonSearchResultPage extends StatelessWidget {
  final PersonSearchController personSearchController = Get.find();
  PersonSearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da busca'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Obx(() => Divider(
                      color: personSearchController.lastPage
                          ? Colors.red
                          : Colors.green,
                    )),
              ),
              Obx(() => Text(
                  '${personSearchController.personList.length} buscas listadas')),
              Expanded(
                child: Obx(() => Divider(
                      color: personSearchController.lastPage
                          ? Colors.red
                          : Colors.green,
                    )),
              ),
            ],
          ),
          Expanded(
            child: Obx(() => PersonList2(
                  personList: personSearchController.personList,
                  nextPage: () => personSearchController.nextPage(),
                  lastPage: personSearchController.lastPage,
                )),
          ),
        ],
      ),
      // body: Obx(() => SingleChildScrollView(
      //       child: Center(
      //         child: Column(
      //           children: buildPeople(context),
      //         ),
      //       ),
      //     )),
    );
  }

  List<Widget> buildPeople(context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');

    List<Widget> list = [];
    for (var e in personSearchController.personList) {
      list.add(InkWell(
        onTap: () => copy(e.id!),
        child: PersonCard(personModel: e),
        // child: Card(
        //   child: Row(
        //     children: [
        //       e.photo != null && e.photo!.isNotEmpty
        //           ? ClipRRect(
        //               borderRadius: BorderRadius.circular(8.0),
        //               child: Image.network(
        //                 e.photo!,
        //                 height: 58,
        //                 width: 58,
        //               ),
        //             )
        //           : const SizedBox(
        //               height: 58, width: 58, child: Icon(Icons.warning)),
        //       // e.photoByte != null && e.photoByte!.isNotEmpty
        //       //     ? Image.memory(
        //       //         Uint8List.fromList(e.photoByte!),
        //       //         width: 75,
        //       //         height: 75,
        //       //         // fit: BoxFit.contain,
        //       //       )
        //       //     : const Text('...'),
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text('Nome: ${e.name}'),
        //             Text('Alias: ${e.alias?.join(",")}'),
        //             Text('Mae: ${e.mother}'),
        //             Text('CPF: ${e.cpf}'),
        //             Text('Marcas: ${e.mark}'),
        //             // Text('DataNasc: ${e.birthday?.toIso8601String()}'),
        //             Text(
        //                 'DataNasc: ${e.birthday != null ? formatter.format(e.birthday!) : "..."}'),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ));
    }
    return list;
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
