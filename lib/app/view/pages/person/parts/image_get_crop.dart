import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageGetCrop extends StatefulWidget {
  XFile? pickedFile;
  CroppedFile? croppedFile;
  Function(XFile?)? setPickedXFile;
  Function(CroppedFile?)? setCroppedFile;
  ImageGetCrop({
    Key? key,
    this.pickedFile,
    this.croppedFile,
    this.setPickedXFile,
    this.setCroppedFile,
  }) : super(key: key);

  @override
  State<ImageGetCrop> createState() => _ImageGetCropState();
}

class _ImageGetCropState extends State<ImageGetCrop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: !kIsWeb ? AppBar(title: const Text('Adicionar imagem')) : null,
      appBar: AppBar(title: const Text('Adicionar imagem')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (kIsWeb)
          //   const Padding(
          //     padding: EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
          //     child: Text(
          //       'Adicionar imagem',
          //       // style: Theme.of(context)
          //       //     .textTheme
          //       //     .displayMedium!
          //       //     .copyWith(color: Theme.of(context).highlightColor),
          //     ),
          //   ),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _body() {
    if (widget.croppedFile != null || widget.pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: _image(),
              ),
            ),
          ),
          // const SizedBox(height: 24.0),
          _menu(),
        ],
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
          maxWidth: 0.7 * screenWidth,
          maxHeight: 0.6 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (widget.pickedFile != null) {
      final path = widget.pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.7 * screenWidth,
          maxHeight: 0.6 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: '0',
          onPressed: () {
            _clear();
          },
          backgroundColor: Colors.redAccent,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        if (widget.croppedFile == null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              heroTag: '1',
              onPressed: () {
                _cropImage();
              },
              backgroundColor: const Color(0xFFBC764A),
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: FloatingActionButton(
            heroTag: '2',
            onPressed: () {
              Get.back();
            },
            backgroundColor: Colors.blueAccent,
            tooltip: 'Enviar este',
            child: const Icon(Icons.check),
          ),
        ),
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: kIsWeb ? 380.0 : 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context).highlightColor,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Upload an image to start',
                            style: kIsWeb
                                ? Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Theme.of(context).highlightColor)
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color:
                                            Theme.of(context).highlightColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    if (widget.pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: widget.pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          // IOSUiSettings(
          //   title: 'Cropper',
          // ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.page,
            boundary: const CroppieBoundary(
              width: 320,
              height: 320,
            ),
            viewPort:
                const CroppieViewPort(width: 180, height: 180, type: 'square'),
            enableExif: true,
            enableOrientation: true,
            enforceBoundary: true,
            enableZoom: true,
            showZoomer: true,
            mouseWheelZoom: true,
            enableResize: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          widget.croppedFile = croppedFile;
          widget.setCroppedFile!(croppedFile);
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        widget.pickedFile = pickedFile;
        widget.setPickedXFile!(pickedFile);
      });
    }
  }

  void _clear() {
    setState(() {
      widget.pickedFile = null;
      widget.croppedFile = null;
      widget.setPickedXFile!(null);
      widget.setCroppedFile!(null);
    });
  }
}
