import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/controllers/presence_controller.dart';
import 'package:presence/app/routes/app_pages.dart';

class BridgeController extends GetxController {
  final count = 0.obs;
  @override
  Future<void> onInit() async {
    print('brodge');
    super.onInit();
    await onPrepare();
    onGoHome();
  }

  onPrepare() {
    Get.put(PresenceController(), permanent: true);
    Get.put(PageIndexController(), permanent: true);
  }

  onGoHome() {
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
