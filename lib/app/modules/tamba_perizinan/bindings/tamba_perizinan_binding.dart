import 'package:get/get.dart';

import '../controllers/tamba_perizinan_controller.dart';

class TambaPerizinanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambaPerizinanController>(
      () => TambaPerizinanController(),
    );
  }
}
