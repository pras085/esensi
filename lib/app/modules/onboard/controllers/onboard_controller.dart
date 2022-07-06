import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/onboard/models/onboard_models.dart';

import '../../../routes/app_pages.dart';

class OnboardController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() async {
    if (isLastPage) {
      //go to home page
      Get.offNamed(Routes.LOGIN);
    } else {
      pageController.nextPage(duration: 200.milliseconds, curve: Curves.linear);
    }
  }

  List<OnboardInfo> onboardingPages = [
    OnboardInfo(
      'assets/vector/1.png',
      'Presensi Dengan Mudah',
      'Aplikasi ini memudahkan karyawan untuk melakukan presensi melalui telepon selulernya masing-masing.',
    ),
    OnboardInfo(
      'assets/vector/2.png',
      'Fitur Face Recognition',
      'Karyawan melakukan scan wajah kemudian sistem akan memverifikasi dengan dataset yang ada pada database.',
    ),
    OnboardInfo(
      'assets/vector/3.png',
      'Presensi Di Mana Saja',
      'Pekerjaan akan terasa lebih mudah karena kegiatan presensi dapat dilakukan di mana saja.',
    ),
  ];
}
