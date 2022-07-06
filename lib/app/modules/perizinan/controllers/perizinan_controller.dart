import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';
import 'package:uuid/uuid.dart';

class PerizinanController extends GetxController {
  TextEditingController alasanC = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime start;
  DateTime end = DateTime.now();

  String uid = FirebaseAuth.instance.currentUser.uid;
  @override
  void onInit() {
    super.onInit();
  }

  Future<QuerySnapshot> getPerizinan() async {
    if (start == null) {
      QuerySnapshot query = await firestore
          .collection("perizinan")
          .where("status", isNotEqualTo: "waiting")
          .where('date', isLessThan: end.toIso8601String())
          .orderBy(
            'status',
            descending: true,
          )
          .get();
      return query;
    } else {
      QuerySnapshot query = await firestore
          .collection("perizinan")
          .where("status", isNotEqualTo: "waiting")
          .where("date", isGreaterThan: start.toIso8601String())
          .where('date',
              isLessThan: end.add(Duration(days: 1)).toIso8601String())
          .orderBy(
            'status',
            descending: true,
          )
          .get();
      return query;
    }
  }

  void pickDate(DateTime startDate, DateTime endDate) {
    start = startDate;
    end = endDate;

    update();
    Get.back();
  }
}
