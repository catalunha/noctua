import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noctua/app/view/pages/person/parts/image_get_crop.dart';

class ImageViewAdd extends StatefulWidget {
  final XFile? pickedXFile;
  final CroppedFile? croppedFile;
  final String? photoActual;
  Function(XFile?)? setPickedXFile;
  Function(CroppedFile?)? setCroppedFile;
  ImageViewAdd({
    Key? key,
    this.pickedXFile,
    this.croppedFile,
    this.photoActual,
    this.setPickedXFile,
    this.setCroppedFile,
  }) : super(key: key);

  @override
  State<ImageViewAdd> createState() => _ImageViewAddState();
}

class _ImageViewAddState extends State<ImageViewAdd> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
        child: InkWell(
          child: _image(),
          onTap: () async {
            await Get.to(
              () => ImageGetCrop(
                pickedFile: widget.pickedXFile,
                croppedFile: widget.croppedFile,
                setPickedXFile: widget.setPickedXFile,
                setCroppedFile: widget.setCroppedFile,
              ),
            );
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (widget.croppedFile != null) {
      final path = widget.croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (widget.pickedXFile != null) {
      final path = widget.pickedXFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (widget.photoActual != null) {
      final path = widget.photoActual!;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.network(path),
      );
    } else {
      // return const SizedBox.shrink();
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.2 * screenWidth,
          maxHeight: 0.15 * screenHeight,
        ),
        child: const Center(
          child: Text(
            'Click aqui para buscar nova imagem',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
