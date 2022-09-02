import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PerizinanChosenController extends GetxController {
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
  Future<DocumentSnapshot> getAllPerizinan(String uid) async {
    DocumentSnapshot query =
        await firestore.collection("perizinan").doc(uid).get();

    return query;
  }
}
