import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DaftarKaryawanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Future<void> onRefresh() async {
    streamPegawai();
  }

  Stream<QuerySnapshot> streamPegawai() async* {
    yield* firestore
        .collection("employee")
        .where('role', isEqualTo: 'employee')
        // .orderBy('role', descending: true)
        .snapshots();
  }
}
