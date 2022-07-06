import 'package:get/get.dart';
import 'package:presence/app/modules/perizinan_admin/controllers/perizinan_admin_controller.dart';


class PerizinanAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerizinanAdminController>(
      () => PerizinanAdminController(),
    );
  }
}
