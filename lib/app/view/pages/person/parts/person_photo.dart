// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:noctua/app/view/controllers/person/person_controller.dart';

// class PersonPhoto extends StatefulWidget {
//   final PersonController _personController = Get.find();
//   final String? photo;
//   PersonPhoto({
//     Key? key,
//     this.photo,
//   }) : super(key: key);

//   @override
//   State<PersonPhoto> createState() => _PersonPhotoState();
// }

// class _PersonPhotoState extends State<PersonPhoto> {
//   final ImagePicker _picker = ImagePicker();
//   // XFile? _pickedFile;
//   bool isLoading = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _pickedFile = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: widget._personController.pickedXFile != null
//           ? Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.blue),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: kIsWeb
//                   ? Image.network(
//                       widget._personController.pickedXFile!.path,
//                       errorBuilder: (BuildContext context, Object exception,
//                           StackTrace? stackTrace) {
//                         ////print'error 1');
//                         return errorBuilderWidget();
//                       },
//                     )
//                   : Image.file(
//                       File(widget._personController.pickedXFile!.path),
//                       errorBuilder: (BuildContext context, Object exception,
//                           StackTrace? stackTrace) {
//                         ////print'error 2');
//                         return errorBuilderWidget();
//                       },
//                     ),
//             )
//           : widget.photo == null
//               ? Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.green),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'Click aqui para buscar nova imagem',
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 )
//               : ClipRRect(
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: Image.network(
//                     widget.photo!,
//                     // loadingBuilder: (_, __, ___) {
//                     //   return const Center(
//                     //       child: CircularProgressIndicator());
//                     // },
//                     height: 100,
//                     width: 100,
//                     errorBuilder: (BuildContext context, Object exception,
//                         StackTrace? stackTrace) {
//                       ////print'error 3');
//                       return errorBuilderWidget();
//                     },
//                   ),
//                 ),
//       onTap: () async {
//         ////print'aqui...');
//         // setState(() {
//         //   _pickedFile = null;
//         // });
//         final XFile? pickedFile =
//             await _picker.pickImage(source: ImageSource.gallery);

//         if (pickedFile != null) {
//           widget._personController.pickedXFile = pickedFile;
//           setState(() {
//             // _pickedFile = pickedFile;
//           });
//         }
//       },
//     );
//   }

//   Container errorBuilderWidget() {
//     return Container(
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.red),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: const Center(
//         child: Text('Erro ao buscar esta imagem'),
//       ),
//     );
//   }
// }
