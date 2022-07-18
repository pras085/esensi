import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/services/facenet_services.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';
import 'package:presence/company_data.dart';

class PresenceController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPresenceToday = false.obs;
  final FaceNetService _faceNetService = FaceNetService();
  // final DataBaseService _dataBaseService = DataBaseService();
  DateTime jamMasuk = DateTime(0, 0, 0, 8, 00);
  DateTime jamKeluar = DateTime(0, 0, 0, 17, 00);
  DateTime now = DateTime.now();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool in_area;
  bool get inAreaValue => in_area;

  //Dataset Wajah Karyawan
  String _predictUser() {
    String faceKaryawan = _faceNetService.predict();
    // print(faceKaryawan);
    return faceKaryawan ?? null;
  }

  presence() async {
    isLoading.value = true;
    Map<String, dynamic> determinePosition = await _determinePosition();
    if (!determinePosition["error"]) {
      Position position = determinePosition["position"];
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String address =
          "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}";
      double distance = Geolocator.distanceBetween(
          CompanyData.office['latitude'],
          CompanyData.office['longitude'],
          position.latitude,
          position.longitude);

      // update position ( store to database )
      await updatePosition(position, address);
      // presence ( store to database )
      await processPresence(position, address, distance);
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi kesalahan", determinePosition["message"]);
      print(determinePosition["error"]);
    }
  }

  firstPresence(
    CollectionReference presenceCollection,
    String todayDocId,
    Position position,
    String address,
    double distance,
    bool in_area,
  ) async {
    var faceKaryawn = _predictUser();
    print('Absen Masuk START');
    if (now.hour.isLowerThan(jamMasuk.hour)) {
      CustomToast.errorToast('Error', 'Belum memasuki jam Masuk');
      Get.back();
      Get.back();
      Get.back();
    }
    if (in_area == false) {
      CustomToast.errorToast('Error', 'Kamu berada di luar radius kantor !');
    } else if (this.auth.currentUser.uid != faceKaryawn) {
      CustomToast.errorToast('Error', 'Wajah tidak dikenali !');
      Get.back();
      Get.back();
    } else {
      CustomAlertDialog.showPresenceAlert(
        title: "Presensi Masuk?",
        message: "Konfirmasi\njika ingin melakukan presensi",
        onCancel: () {
          Get.back();
          Get.back();
          Get.back();
          // Get.back();
        },
        onConfirm: () async {
          Get.back();
          Get.back();
          Get.defaultDialog(
            actions: null,
            title: "Mohon Tunggu",
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );
          await presenceCollection.doc(todayDocId).set(
            {
              "date": DateTime.now().toIso8601String(),
              "masuk": {
                "date": DateTime.now().toIso8601String(),
                "latitude": position.latitude,
                "longitude": position.longitude,
                "address": address,
                "in_area": in_area,
                "distance": distance,
              }
            },
          );
          // Get.back();
          Get.offNamed(Routes.HOME);
          print('ABSEN BERHASIL');
          CustomToast.successToast("Success", "success check in");
        },
      );
    }
  }

  checkinPresence(
    CollectionReference presenceCollection,
    String todayDocId,
    Position position,
    String address,
    double distance,
    bool in_area,
  ) async {
    var faceKaryawn = _predictUser();
    if (in_area == false) {
      print(in_area);
      CustomToast.errorToast('Error', 'Kamu berada di luar radius kantor !');
    } else {
      if (now.hour.isLowerThan(jamMasuk.hour)) {
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        await CustomToast.errorToast('Error', 'Belum memasuki jam Masuk');
      } else if (this.auth.currentUser.uid != faceKaryawn) {
        CustomToast.errorToast('Error', 'Wajah tidak dikenali !');
        Get.back();
        Get.back();
      } else {
        CustomAlertDialog.showPresenceAlert(
          title: "Presensi Masuk?",
          message: "Konfirmasi jika ingin\nmelakukan presensi",
          onCancel: () {
            Get.back();
            Get.back();
            Get.back();
            Get.back();
          },
          onConfirm: () async {
            Get.back();
            Get.back();

            Get.defaultDialog(
              titleStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: AppColor.navigationColor),
              title: "Mohon Tunggu",
              content: Center(
                child: CircularProgressIndicator(),
              ),
            );
            await presenceCollection.doc(todayDocId).set(
              {
                "date": DateTime.now().toIso8601String(),
                "masuk": {
                  "date": DateTime.now().toIso8601String(),
                  "latitude": position.latitude,
                  "longitude": position.longitude,
                  "address": address,
                  "in_area": in_area,
                  "distance": distance,
                }
              },
            );
            Get.offNamed(Routes.HOME);
            print('ABSEN BERHASIL');
            CustomToast.successToast("Success", "success check in");
          },
        );
      }
    }
  }

  checkoutPresence(
    CollectionReference presenceCollection,
    String todayDocId,
    Position position,
    String address,
    double distance,
    bool in_area,
  ) async {
    CustomAlertDialog.showPresenceAlert(
      title: "Presensi Keluar?",
      message: "Konfirmasi jika ingin\nmelakukan presensi",
      onCancel: () {
        Get.back();
        Get.back();
        Get.back();
        // Get.back();
      },
      onConfirm: () async {
        if (now.hour.isLowerThan(jamMasuk.hour)) {
          Get.back();
          Get.back();
          Get.back();
          Get.back();
          Get.back();
          CustomToast.errorToast('Error', 'Belum memasuki jam keluar');
        }
        Get.back();
        Get.back();
        Get.defaultDialog(
          actions: null,
          title: "Mohon Tunggu",
          content: Center(
            child: CircularProgressIndicator(),
          ),
        );
        await presenceCollection.doc(todayDocId).update(
          {
            "keluar": {
              "date": DateTime.now().toIso8601String(),
              "latitude": position.latitude,
              "longitude": position.longitude,
              "address": address,
              "in_area": in_area,
              "distance": distance,
            }
          },
        );
        Get.offNamed(Routes.HOME);
        print('ABSEN BERHASIL');
        CustomToast.successToast("Berhasil", "Melakukan presensi");
      },
    );
  }

  Future<void> processPresence(
      Position position, String address, double distance) async {
    String uid = auth.currentUser.uid;
    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    //Database
    CollectionReference presenceCollection =
        await firestore.collection("employee").doc(uid).collection("presence");
    QuerySnapshot snapshotPreference = await presenceCollection.get();
    //Wajah Database Lokal
    // var faceKaryawan = _predictUser();

    bool in_area = false;
    if (distance <= 200) {
      in_area = true;
    }

    if (snapshotPreference.docs.length == 0) {
      //case :  never presence -> set check in presence

      firstPresence(
          presenceCollection, todayDocId, position, address, distance, in_area);
    } else {
      DocumentSnapshot todayDoc =
          await presenceCollection.doc(todayDocId).get();
      // already presence before ( another day ) -> have been check in today or check out?
      if (todayDoc.exists == true) {
        Map<String, dynamic> dataPresenceToday = todayDoc.data();
        // case : already check in
        if (dataPresenceToday["keluar"] != null) {
          // case : already check in and check out
          CustomToast.successToast(
              "Success", "Kamu sudah melakukan presensi hari ini");
          Get.back();
        } else {
          // case : already check in and not yet check out ( check out )
          checkoutPresence(presenceCollection, todayDocId, position, address,
              distance, in_area);
          isPresenceToday.value = true;
        }
      } else {
        // case : not yet check in today
        checkinPresence(presenceCollection, todayDocId, position, address,
            distance, in_area);
      }
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser.uid;
    await firestore.collection("employee").doc(uid).update({
      "position": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
      "address": address,
    });
  }

  Future<Map<String, dynamic>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
          "message":
              "Tidak dapat mengakses karena anda menolak permintaan lokasi",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Location permissions are permanently denied, we cannot request permissions.",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return {
      "position": position,
      "message": "Berhasil mendapatkan posisi device",
      "error": false,
    };
  }
}
