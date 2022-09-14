import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noctua/app/view/controllers/person/search/people_search_controller.dart';

class Calendar2Button extends StatelessWidget {
  final PersonSearchController personSearchController = Get.find();
  final dateFormat = DateFormat('dd/MM/y');

  Calendar2Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var initialDate = personSearchController.selectedDate ?? DateTime.now();
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year + 1),
        );
        personSearchController.selectedDate = selectedDate;
      },
      // borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Obx(
              () {
                if (personSearchController.selectedDate != null) {
                  return Text(
                      'Nascimento:  ${dateFormat.format(personSearchController.selectedDate!)}');
                } else {
                  return const Text('Nascimento: Selecione uma data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
