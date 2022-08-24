import 'package:flutter/material.dart';
import 'package:noctua/app/domain/models/person_model.dart';

class PersonCard extends StatelessWidget {
  final PersonModel personModel;
  const PersonCard({Key? key, required this.personModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        'https://parsefiles.back4app.com/SLWtrlBJSzdUpAvA2Jh1aXkr87k65vuB3Mjvkjco/ec44adbb2d9ea27fe64a8607b00586e1_a3.png',
        height: 50,
        width: 50,
      ),
      title: Text(personModel.id!),
    );
  }
}
