import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_products_controller.dart';

class AddProductsView extends GetView<AddProductsController> {
  const AddProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController _productCode = TextEditingController();
    TextEditingController _productname = TextEditingController();
    TextEditingController _quantityProduct = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProductsView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            autocorrect: false,
            controller: _productCode,
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
            controller: _productname,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                label: const Text('Nama Produk')),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            autocorrect: false,
            controller: _productname,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                label: const Text('Jumlah')),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton.icon(
            onPressed: () async {
              //cek kalau kondisi aplikasinya
              if (controller.isLoading.isFalse) {
                controller.isLoading.isFalse;
              }
            },
            icon: const Icon(Icons.login_outlined),
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
