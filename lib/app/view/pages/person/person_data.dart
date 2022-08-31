import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/utils/app_assets.dart';
import 'package:noctua/app/view/pages/utils/app_theme.dart';

class PersonData extends StatelessWidget {
  final PersonController _personController = Get.find();
  final dateFormat = DateFormat('dd/MM/y');

  PersonData({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(_personController.person!.isMale ? "Homem" : "Mulher"),
              _personController.person!.photo != null &&
                      _personController.person!.photo!.isNotEmpty
                  ? Image.network(
                      _personController.person!.photo!,
                    )
                  : Image.asset(AppAssets.logo),
              const Text('Apelido:'),
              Text(
                _personController.person?.alias?.join(", ") ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Nome:'),
              Text(
                _personController.person?.name ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('CPF:'),
              Text(
                _personController.person?.cpf ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Nascimento:'),
              Text(
                _personController.person?.birthday != null
                    ? dateFormat.format(_personController.person!.birthday!)
                    : "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Mãe:'),
              Text(
                _personController.person?.mother ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Caracteristicas:'),
              Text(
                _personController.person?.note ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              const Text('Historico:'),
              Text(
                _personController.person?.history ?? "...",
                style: AppTheme.textRed18Bold,
              ),
              Text(
                  'Leis (${_personController.person?.laws?.length.toString() ?? ""}):'),
              Text(
                _personController.person?.laws
                        ?.map((e) => e.note)
                        .toList()
                        .join('\n') ??
                    "...",
                style: AppTheme.textRed18Bold,
              ),
              Text(
                  'Imagens (${_personController.person?.images?.length.toString() ?? ""}):'),
              if (_personController.person!.images != null &&
                  _personController.person!.images!.isNotEmpty)
                ..._personController.person!.images!
                    .map((e) => Image.network(
                          e.photo!,
                        ))
                    .toList()
            ],
          ),
        ),
      ),
    );
  }
}
