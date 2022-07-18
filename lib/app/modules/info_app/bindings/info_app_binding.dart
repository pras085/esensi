import 'package:get/get.dart';

import '../controllers/info_app_controller.dart';

class InfoAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoAppController>(
      () => InfoAppController(),
    );
  }
}
