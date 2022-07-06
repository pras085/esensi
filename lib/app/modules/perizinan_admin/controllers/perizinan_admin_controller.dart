import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PerizinanAdminController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<QuerySnapshot> getAllPerizinan() async {
    QuerySnapshot query = await firestore
        .collection("perizinan")
        .where("status", isEqualTo: 'waiting')
        .get();
    return query;
  }
}
