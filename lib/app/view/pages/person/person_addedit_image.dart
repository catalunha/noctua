import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/person/parts/person_photo.dart';
import 'package:noctua/app/view/pages/utils/app_theme.dart';

class PersonAddEditImage extends StatefulWidget {
  final PersonController _personController = Get.find();

  PersonAddEditImage({Key? key}) : super(key: key);

  @override
  State<PersonAddEditImage> createState() => _PersonAddEditImageState();
}

class _PersonAddEditImageState extends State<PersonAddEditImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar imagem para')),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${MediaQuery.of(context).size.width}'),
                const Text('Pessoa com apelido:'),
                Text(
                  widget._personController.person?.alias?.join(", ") ?? "...",
                  style: AppTheme.textRed18Bold,
                ),
                const SizedBox(height: 5),
                Text(
                    'Imagens já disponíveis (${widget._personController.person?.images?.length.toString() ?? ""}):'),
                if (widget._personController.person!.images != null &&
                    widget._personController.person!.images!.isNotEmpty)
                  ...widget._personController.person!.images!
                      .map((e) => image(e.id!, e.photo!))
                      .toList(),
                PersonPhoto(),
                ElevatedButton(
                    onPressed: () {
                      widget._personController.onAddEditImage();
                    },
                    child: const Text('Enviar'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget image(String id, String photo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          width: MediaQuery.of(context).size.width * .8,
          // fit: BoxFit.fitWidth,
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          // width: 300,
          photo,
        ),
        IconButton(
          onPressed: () {
            widget._personController.onDeleteImage(id);
          },
          icon: const Icon(Icons.delete_forever),
        )
      ],
    );
  }
}