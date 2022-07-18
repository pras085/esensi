import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PerizinanController extends GetxController {
  TextEditingController alasanC = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime dateDb;
  String today;

  // String todayDocId = DateFormat('EEEE, d MMMM yyyy', 'id_ID')
  //     .format(DateTime.now())
  //     .replaceAll("/", "-");
// DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(perizinanData["date"]))
  String uid = FirebaseAuth.instance.currentUser.uid;
  @override
  void onInit() async {
    super.onInit();
    await getToday();
  }

  Future<QuerySnapshot> getPerizinan() async {
    if (dateDb == null) {
      QuerySnapshot query = await firestore
          .collection("perizinan")
          // .where("date", isLessThanOrEqualTo: "${end.toIso8601String()}")
          .where('status', isNotEqualTo: dateDb.toIso8601String())
          .orderBy(
            'status',
            descending: true,
          )
          .get();

      return query;
    } else {
      String dateFormat = DateFormat('yyyy-MM-d', 'id_ID').format(dateDb);
      String dateFormatView =
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(dateDb);
      print('FORMAT : $dateFormat');
      today = dateFormatView;
      update();
      QuerySnapshot query = await firestore
          .collection("perizinan")
          // .where("status", isNotEqualTo: "waiting")
          .where('date', isLessThanOrEqualTo: '$dateFormat')
          // .where("date", isGreaterThanOrEqualTo: '$dateFormat')
          // .where("date", isEqualTo: '2022-07-07T06:33:42.280265')
          .get();
      //     .then(
      //   (query) async {
      //     QuerySnapshot query = await firestore
      //         .collection("perizinan")
      //         //         // .where("date", isLessThan: "${end.toIso8601String()}")
      //         .where('status', isNotEqualTo: 'waiting')
      //         //         .orderBy(
      //         //           'status',
      //         //           descending: true,
      //         //         )
      //         .get();
      //     return query;
      //   },
      // );
      return query;
    }
  }

  void pickDate(datePicked) {
    dateDb = datePicked;
    Get.back();
    update();
  }

  void getToday() {
    if (dateDb == null) {
      dateDb = DateTime.now();
    }
  }
}
