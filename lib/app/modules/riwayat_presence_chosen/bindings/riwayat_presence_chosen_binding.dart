import 'package:get/get.dart';

import '../controllers/riwayat_presence_chosen_controller.dart';

class RiwayatPresenceChosenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatPresenceChosenController>(
      () => RiwayatPresenceChosenController(),
    );
  }
}
