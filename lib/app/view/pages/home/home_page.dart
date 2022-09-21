import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/routes.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/home/parts/popmenu_user.dart';
import 'package:noctua/app/view/pages/person/parts/person_list.dart';

class HomePage extends StatefulWidget {
  final SplashController _splashController = Get.find();
  final PersonController _personController = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "Olá, ${widget._splashController.userModel!.profile!.name ?? 'Atualize seu perfil.'}.")),
        actions: [
          // const IconButton(
          //     onPressed: () => widget._homeController.createAccount(),
          //     icon: Icon(Icons.abc)),
          PopMenuButtonPhotoUser(),
        ],
      ),
      body: Column(
        children: [
          Wrap(
            children: [
              IconButton(
                onPressed: () => widget._personController.listAll(),
                icon: const Icon(Icons.person_pin_rounded),
              ),
              IconButton(
                onPressed: () => widget._personController.add(),
                icon: const Icon(Icons.person_add),
              ),
              IconButton(
                onPressed: () => Get.toNamed(Routes.personSearch),
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () => Get.toNamed(Routes.operation),
                icon: const Icon(Icons.lock_open_rounded),
              ),
            ],
          ),
          Expanded(child: SingleChildScrollView(child: PersonList())),
        ],
      ),
    );
  }
}
