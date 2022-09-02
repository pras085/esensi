import 'dart:developer';

import 'package:get/get.dart';

class DetailPresenceController extends GetxController {
  DateTime jamMasukKantor = DateTime(0, 0, 0, 8, 00);
  DateTime jamKeluarKantor = DateTime(0, 0, 0, 17, 00);
  Map<String, dynamic> presenceData;
  Map<String, dynamic> userData;
  DateTime jamMasuk;
  DateTime jamKeluar;

  @override
  void onInit() async {
    super.onInit();
    presenceData = Get.arguments;
    userData = Get.arguments;
    await getData();

    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getData() {
    log('getData');
    jamMasuk = DateTime.parse(presenceData['masuk']["date"]);
    jamKeluar = DateTime.parse(presenceData['keluar']["date"]);
    update();
  }
}
