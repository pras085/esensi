import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PresensiTodayController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String todayDocId =
      DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
  final count = 0.obs;
  DateTime end = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;

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

  Future<QuerySnapshot> getAllPresenceToday() async {
    QuerySnapshot query = await firestore.collection("presence").get();
    return query;
  }

  Future<QuerySnapshot> getAllUser() async {
    QuerySnapshot query = await firestore
        .collection("employee")
        .orderBy('employee_id', descending: false)
        .get();
    return query;
  }

  Stream<DocumentSnapshot> streamAllPresensi(String uid) async* {
    yield* firestore
        .collection("employee")
        .doc(uid)
        .collection("presence")
        .doc(todayDocId)
        .snapshots();
  }
}
