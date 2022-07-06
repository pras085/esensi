import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';
import '../controllers/bridge_controller.dart';

class BridgeView extends GetView<BridgeController> {
  BridgeController bridgeController = Get.put(BridgeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Image.asset(
          'assets/vector/logo_splash.png',
          scale: 2,
        ),
      ),
    );
  }
}
