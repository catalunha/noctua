import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/routes.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:noctua/app/view/controllers/person/person_controller.dart';
import 'package:noctua/app/view/pages/home/parts/popmenu_user.dart';
import 'package:noctua/app/view/pages/person/parts/person_list2.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final SplashController _splashController = Get.find();

  final PersonController _personController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "Olá, ${_splashController.userModel!.profile!.name ?? 'Atualize seu perfil.'}.")),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.personSearch),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => Get.toNamed(Routes.operation),
            icon: const Icon(Icons.lock_open_rounded),
          ),
          const SizedBox(
            width: 5,
          ),
          PopMenuButtonPhotoUser(),
        ],
      ),
      body: Obx(() => PersonList2(
            personList: _personController.personList,
            nextPage: () => _personController.nextPage(),
            lastPage: _personController.lastPage,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _personController.add(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
