import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DaftarKaryawanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onDeleteUser(var uid) {
    Get.back();
    Get.defaultDialog(
      actions: null,
      title: "Mohon Tunggu",
      content: Center(
        child: CircularProgressIndicator(),
      ),
    );
    firestore.collection("employee").doc(uid).delete().then((value) {
      Get.back();
    });
  }

  Future<void> onRefresh() async {
    streamPegawai();
    await update();
  }

  Stream<QuerySnapshot> streamPegawai() async* {
    yield* firestore
        .collection("employee")
        .orderBy('created_at', descending: false)
        .snapshots();
  }
}
