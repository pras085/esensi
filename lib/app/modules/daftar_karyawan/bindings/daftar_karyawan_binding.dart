import 'package:get/get.dart';

import '../controllers/daftar_karyawan_controller.dart';

class DaftarKaryawanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarKaryawanController>(
      () => DaftarKaryawanController(),
    );
  }
}
