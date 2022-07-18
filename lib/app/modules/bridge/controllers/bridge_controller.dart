import 'dart:async';

import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/controllers/presence_controller.dart';
import 'package:presence/app/routes/app_pages.dart';

class BridgeController extends GetxController {
  // final pageIndexController = Get.find<PageIndexController>();

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    print('brodge');
    super.onInit();
    await Timer(Duration(seconds: 4), () async {
      await onPrepare();
      await onGoHome();
    });
  }

  onPrepare() {
    Get.put(PresenceController(), permanent: true);
    Get.put(PageIndexController(), permanent: true);
  }

  onGoHome() {
    PageIndexController pageIndexC = Get.find<PageIndexController>();
    pageIndexC.changePage(0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
