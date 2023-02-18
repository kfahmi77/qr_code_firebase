import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_firebase/app/controllers/auth_controller.dart';
import 'package:qr_code_firebase/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> hasil = await authController.logout();
          if (hasil['error'] == false) {
            Get.offAllNamed(Routes.login);
          } else {
            Get.snackbar('Error', hasil['message']);
          }
        },
        child: const Icon(Icons.logout_outlined),
      ),
    );
  }
}
