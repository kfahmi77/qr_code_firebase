import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: 'admin@gmail.com');
    final TextEditingController passwordController =
        TextEditingController(text: 'fahmi0810');

    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            autocorrect: false,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              label: const Text('Email'),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => TextField(
              autocorrect: false,
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: controller.isHidden.value,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () => controller.isHidden.toggle(),
                      icon: Icon(controller.isHidden.isFalse
                          ? Icons.remove_red_eye_rounded
                          : Icons.remove_red_eye_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  label: const Text('Password')),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton.icon(
            onPressed: () async {
              //cek kalau kondisi aplikasinya
              if (controller.isLoading.isFalse) {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  controller.isLoading.isTrue;
                  Map<String, dynamic> hasil = await authController.login(
                      emailController.text, passwordController.text);
                  controller.isLoading.isFalse;

                  if (hasil['error'] == true) {
                    Get.snackbar("error", hasil["message"],
                        icon: Icon(Icons.error));
                  } else {
                    Get.offAllNamed(Routes.home);
                  }
                } else {
                  Get.snackbar('error', 'Email dan password harus diisi');
                }
              }
            },
            icon: const Icon(Icons.login_outlined),
            label: Obx(
                () => Text(controller.isLoading.isFalse ? 'Login' : 'Loading')),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(vertical: 16)),
          )
        ],
      ),
    );
  }
}
