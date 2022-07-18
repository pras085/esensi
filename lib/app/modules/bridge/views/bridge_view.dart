import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:presence/app/style/app_color.dart';
import '../controllers/bridge_controller.dart';

class BridgeView extends GetView<BridgeController> {
  BridgeController bridgeController = Get.put(BridgeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor.withOpacity(0.7),
      body: Container(
          alignment: Alignment.center,
          child: Lottie.asset(
            'assets/images/loading.json',
            frameRate: FrameRate.max,
            animate: true,
            height: 200,
            width: 130,
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          )),
    );
  }
}
