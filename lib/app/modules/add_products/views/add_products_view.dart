import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_products_controller.dart';

class AddProductsView extends GetView<AddProductsController> {
  const AddProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController productCode = TextEditingController();
    TextEditingController productname = TextEditingController();
    TextEditingController quantityProduct = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            autocorrect: false,
            controller: productCode,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              label: const Text('Kode Produk'),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            autocorrect: false,
            controller: productname,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                label: const Text('Nama Produk')),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: quantityProduct,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                label: const Text('Jumlah')),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () async {
              //cek kalau kondisi aplikasinya
              if (controller.isLoading.isFalse) {
                if (productCode.text.isNotEmpty &&
                    productname.text.isNotEmpty &&
                    quantityProduct.text.isNotEmpty) {
                  Map<String, dynamic> hasil = await controller.addProduct({
                    "code": productCode.text,
                    "name": productname.text,
                    "qty": int.tryParse(quantityProduct.text) ?? 0
                  });
                  controller.isLoading(false);
                  Get.back();
                  if (hasil["error"] == false) {
                    Get.snackbar(hasil["error"] == true ? "Error" : "success",
                        hasil["message"]);
                  }
                } else {
                  Get.snackbar("error", "Data wajib diisi");
                }
                controller.isLoading.isFalse;
              }
            },
            icon: const Icon(Icons.add),
            label: Obx(() => Text(
                controller.isLoading.isFalse ? 'Tambah produk' : 'Loading')),
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
