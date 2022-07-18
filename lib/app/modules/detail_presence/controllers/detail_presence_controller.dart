import 'package:get/get.dart';

class DetailPresenceController extends GetxController {
  DateTime jamMasuk = DateTime(0, 0, 0, 8, 00);
  DateTime jamKeluar = DateTime(0, 0, 0, 17, 00);
  Map<String, dynamic> presenceData;
  Map<String, dynamic> userData;

  @override
  void onInit() {
    super.onInit();
    presenceData = Get.arguments;
    userData = Get.arguments;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
