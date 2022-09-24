import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/view/pages/person/parts/person_card.dart';

class PersonList2 extends StatelessWidget {
  final List<PersonModel> personList;
  final Function() nextPage;
  final bool lastPage;
  const PersonList2(
      {super.key,
      required this.personList,
      required this.nextPage,
      required this.lastPage});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LazyLoadScrollView(
        onEndOfPage: () => nextPage(),
        scrollOffset: 2,
        isLoading: lastPage,
        child: ListView.builder(
          itemCount: personList.length,
          itemBuilder: (context, index) {
            final person = personList[index];
            return PersonCard(
              personModel: person,
            );
          },
        ),
      ),
    );
  }
}
