import 'package:get/get.dart';

import '../controllers/detail_perizinan_controller.dart';

class DetailPerizinanBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPerizinanController>(
      () => DetailPerizinanController(),
    );
  }
}
