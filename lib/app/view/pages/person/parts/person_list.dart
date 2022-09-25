// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:noctua/app/view/controllers/person/person_controller.dart';
// import 'package:noctua/app/view/pages/person/parts/person_card.dart';

// class PersonList extends StatelessWidget {
//   final PersonController _personController = Get.find();

//   PersonList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Column(children: personList()));
//   }

//   List<Widget> personList() {
//     List<Widget> list = [];
//     list.addAll(_personController.personList
//         .map((e) => PersonCard(personModel: e))
//         .toList());
//     return list;
//   }
// }
