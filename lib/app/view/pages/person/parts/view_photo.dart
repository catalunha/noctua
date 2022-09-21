import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ViewPhoto extends StatefulWidget {
  final XFile? pickedFile;
  final CroppedFile? croppedFile;
  final String? photoActual;
  const ViewPhoto({
    Key? key,
    this.pickedFile,
    this.croppedFile,
    this.photoActual,
  }) : super(key: key);

  @override
  State<ViewPhoto> createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
        child: _image(),
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
    } else if (widget.pickedFile != null) {
      final path = widget.pickedFile!.path;
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
