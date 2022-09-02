import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/services/shared_preferences.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';
import 'package:presence/company_data.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool inRadius = false.obs;
  var valueTesting = "0".obs;
  var role = "".obs;

  RxString officeDistance = "-".obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    super.onInit();
    print('home-contr');

    PreferenceService.setStatus("logged");

    onRefresh();
  }

  onRefresh() async {
    onGetProfile();
    await getDistanceToOffice().then((value) {
      officeDistance.value = value;
    });
  }

  onGetProfile() async {
    String auth = FirebaseAuth.instance.currentUser.uid;

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //Database
    CollectionReference user = await firestore.collection("employee");
    user.doc(auth).get().then((valueUser) {
      log(valueUser['role']);
      role.value = valueUser['role'];
    });
  }

  launchOfficeOnMap() {
    try {
      MapsLauncher.launchCoordinates(
        CompanyData.office['latitude'],
        CompanyData.office['longitude'],
      );
    } catch (e) {
      CustomToast.errorToast('Error', 'Error : ${e}');
    }
  }

  Future<String> getDistanceToOffice() async {
    double distance;
    print('cekLokasi');
    Map<String, dynamic> determinePosition = await _determinePosition();
    if (!determinePosition["error"]) {
      Position position = determinePosition["position"];
      if (valueTesting.value == "0") {
        distance = Geolocator.distanceBetween(
            CompanyData.office['latitude'],
            CompanyData.office['longitude'],
            position.latitude,
            position.longitude);
      } else {
        distance = Geolocator.distanceBetween(
            CompanyData.office['latitudePnm'],
            CompanyData.office['longitudePnm'],
            position.latitude,
            position.longitude);
      }
      if (distance < 250) {
        inRadius.value = true;
      } else {
        inRadius.value = false;

        CustomToast.errorToast('Error', 'Anda berada di luar radius kantor !');
      }
      print(inRadius.value);
      if (distance > 1000) {
        print(distance);
        return "${(distance / 1000).toStringAsFixed(2)}km";
      } else {
        print(distance);
        return "${distance.toStringAsFixed(2)}m";
      }
    } else {
      return "-";
    }
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
      Get.rawSnackbar(
        title: 'GPS is off',
        message: 'you need to turn on gps',
        duration: Duration(seconds: 3),
      );
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

  Stream<DocumentSnapshot> streamUser() async* {
    String uid = auth.currentUser.uid;
    yield* firestore.collection("employee").doc(uid).snapshots();
  }

  Stream<QuerySnapshot> streamLastPresence() async* {
    String uid = auth.currentUser.uid;
    yield* firestore
        .collection("employee")
        .doc(uid)
        .collection("presence")
        .orderBy("date", descending: true)
        .limit(3)
        .snapshots();
  }

  Stream<DocumentSnapshot> streamTodayPresence() async* {
    String uid = auth.currentUser.uid;
    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    yield* firestore
        .collection("employee")
        .doc(uid)
        .collection("presence")
        .doc(todayDocId)
        .snapshots();
  }

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
    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    yield* firestore
        .collection("employee")
        .doc(uid)
        .collection("presence")
        .doc(todayDocId)
        .snapshots();
  }
}
