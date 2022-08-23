import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noctua/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:noctua/app/view/controllers/home/home_controller.dart';
import 'package:noctua/app/view/pages/home/parts/popmenu_user.dart';

class HomePage extends StatefulWidget {
  final SplashController _splashController = Get.find();
  final HomeController _homeController = Get.find();

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
      body: buildSearch(),
    );
  }

  Widget buildSearch() {
    return const Center(
      child: Text('Vá e Vença',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
    );
  }
}
