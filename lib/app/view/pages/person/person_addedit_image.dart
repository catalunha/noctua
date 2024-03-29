import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/person/parts/image_view_add.dart';
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
      appBar: AppBar(title: const Text('Gerenciar imagens para')),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Pessoa com apelido:'),
                Text(
                  widget._personController.person?.alias?.join(", ") ?? "...",
                  style: AppTheme.textRed18Bold,
                ),
                const SizedBox(height: 5),
                Text(
                    'Imagens já disponíveis (${widget._personController.personImageList.length}):'),
                if (widget._personController.personImageList.isNotEmpty)
                  ...widget._personController.personImageList
                      .map((e) => image(e.id!, e.photo!))
                      .toList(),
                ImageViewAdd(
                  pickedXFile: widget._personController.pickedXFile,
                  croppedFile: widget._personController.croppedFile,
                  // photoActual: widget._personController.person?.photo,
                  setPickedXFile: (value) {
                    widget._personController.setPickedXFile(value);
                    setState(() {});
                  },
                  setCroppedFile: (value) {
                    widget._personController.setCroppedFile(value);
                    setState(() {});
                  },
                ),
                // PersonPhoto(),
                // ViewPhoto(
                //   pickedFile: widget._personController.pickedXFile,
                //   croppedFile: widget._personController.croppedFile,
                //   // photoActual: widget._personController.person?.photo,
                // ),
                // IconButton(
                //   icon: const Icon(Icons.image),
                //   onPressed: () async {
                //     // Get.toNamed(Routes.personAddPhoto);
                //     await Get.to(
                //       () => AddPhoto(
                //         pickedFile: widget._personController.pickedXFile,
                //         croppedFile: widget._personController.croppedFile,
                //         setPickedXFile: (value) =>
                //             widget._personController.setPickedXFile(value),
                //         setCroppedFile: (value) {
                //           widget._personController.setCroppedFile(value);
                //         },
                //       ),
                //     );
                //     // print(widget._personController.pickedXFile!.path);
                //     setState(() {});
                //   },
                // ),
                ElevatedButton(
                    onPressed: () {
                      widget._personController.onAddImage();
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
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          // width: MediaQuery.of(context).size.width * .8,

          photo,
        ),
        IconButton(
          onPressed: () {
            widget._personController.onDeleteImage(id);
          },
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
