import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:noctua/app/domain/models/person_model.dart';
import 'package:noctua/app/view/pages/utils/app_assets.dart';
import 'package:noctua/app/view/pages/utils/app_theme.dart';

class PersonData extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/y');
  PersonModel? personModel;
  PersonData({
    Key? key,
    this.personModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    personModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados da pessoa'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(personModel!.isFemale ? "Homem" : "Mulher"),
              personModel!.photo != null && personModel!.photo!.isNotEmpty
                  ? Image.network(
                      personModel!.photo!,
                    )
                  : Image.asset(AppAssets.logo),
              const Text('Apelido:'),
              Text(
                personModel!.alias?.join(", ") ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Nome:'),
              Text(
                personModel!.name ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('CPF:'),
              Text(
                personModel!.cpf ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Nascimento:'),
              Text(
                personModel!.birthday != null
                    ? dateFormat.format(personModel!.birthday!)
                    : "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Mãe:'),
              Text(
                personModel!.mother ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Caracteristicas:'),
              Text(
                personModel!.mark ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Historico:'),
              Text(
                personModel!.history ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              Text('Leis (${personModel!.laws?.length.toString() ?? ""}):'),
              Text(
                personModel!.laws
                        ?.map((e) => e.description)
                        .toList()
                        .join('\n') ??
                    "...",
                style: AppTheme.textRed18Bold,
              ),
              Text(
                  'Imagens (${personModel!.images?.length.toString() ?? ""}):'),
              if (personModel!.images != null &&
                  personModel!.images!.isNotEmpty)
                ...personModel!.images!
                    .map((e) => Image.network(
                          e.photo!,
                        ))
                    .toList(),
              const Divider(),
              const Text('id:'),
              Text(
                personModel!.id!,
                style: AppTheme.textRed18Bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
