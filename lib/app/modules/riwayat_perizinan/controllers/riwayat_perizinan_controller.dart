import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatPerizinanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser.uid;

  @override
  void onInit() {
    super.onInit();
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<QuerySnapshot> getPerizinan() async {
    QuerySnapshot query = await firestore
        .collection("perizinan")
        .where('idUser', isEqualTo: uid)
        .orderBy('status', descending: true)
        .get();
    return query;
  }
}
