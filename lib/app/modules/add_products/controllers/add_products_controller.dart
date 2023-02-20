import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductsController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      DocumentReference<Map<String, dynamic>> hasil =
          await firebaseFirestore.collection("products").add(data);
      await firebaseFirestore
          .collection("products")
          .doc(hasil.id)
          .update({"productId": hasil.id});

      return {
        "error": false,
        "message": "berhasil menambah produk",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "tidak dapat menambah produk",
      };
    }
  }
}
