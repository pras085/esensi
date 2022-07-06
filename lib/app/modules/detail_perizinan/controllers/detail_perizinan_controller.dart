import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/home/controllers/home_controller.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';

class DetailPerizinanController extends GetxController {
  final count = 0.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  HomeController homeC = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  onAcc(String idPerizinan) async {
    print("id : $idPerizinan");
    await firestore
        .collection("perizinan")
        .doc(idPerizinan)
        .update({"status": "true"}).then((value) {
      update();
      Get.back();
      Get.back();
      CustomToast.successToast("Succes", "Berhasil update perizinan");
    });
  }

  onReject(String idPerizinan) async {
    await firestore
        .collection("perizinan")
        .doc(idPerizinan)
        .update({"status": "false"}).then((value) {
      update();
      Get.back();
      Get.back();
      CustomToast.successToast("Succes", "Berhasil update perizinan");
    });
  }
}
