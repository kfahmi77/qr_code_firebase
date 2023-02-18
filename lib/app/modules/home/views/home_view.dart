import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          late String title;
          late IconData icon;

          late VoidCallback ontap;
          switch (index) {
            case 0:
              title = 'Produk';
              icon = Icons.add_card_rounded;
              ontap = () => Get.toNamed(Routes.products);
              break;
            case 1:
              title = 'tambah Produk';
              ontap = () => Get.toNamed(Routes.addProducts);
              icon = Icons.add_box_rounded;
              break;
            case 2:
              title = 'Kode QR';
              ontap = () => print('qr code');
              icon = Icons.qr_code;
              break;
            case 3:
              title = 'Katalog';
              icon = Icons.document_scanner;
              ontap = () => print('katalog');
              break;
            default:
          }
          return Material(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => ontap(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      icon,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(title),
                ],
              ),
            ),
          );
        },
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
