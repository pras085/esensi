import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RiwayatPresenceChosenController extends GetxController {
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

  Future<QuerySnapshot> getAllPresence(String uid) async {
    QuerySnapshot query = await firestore
        .collection("employee")
        .doc(uid)
        .collection("presence")
        .orderBy(
          "date",
          descending: true,
        )
        .get();
    return query;
  }
}
