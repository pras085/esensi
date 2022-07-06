import 'package:get/get.dart';

import '../controllers/bridge_controller.dart';

class BridgeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BridgeController>(
      () => BridgeController(),
    );
  }
}
