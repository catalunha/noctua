import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/person/parts/person_list.dart';
import 'package:noctua/app/view/pages/utils/app_textformfield.dart';

class PersonSearch extends StatefulWidget {
  final PersonController _personController = Get.find();

  PersonSearch({Key? key}) : super(key: key);

  @override
  State<PersonSearch> createState() => _PersonSearchState();
}

class _PersonSearchState extends State<PersonSearch> {
  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTec.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(
        //   height: 10,
        // ),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: AppTextFormField(
                label: 'Digite termos para busca',
                controller: _nameTec,
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  widget._personController.listAll();
                },
                icon: const Icon(Icons.search),
              ),
            )
          ],
        ),
        Expanded(child: SingleChildScrollView(child: PersonList())),
      ],
    );
  }
}
