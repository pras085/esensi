// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_declarations, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/onboard/controllers/onboard_controller.dart';

import '../../../style/app_color.dart';
import '../models/onboard_models.dart';

class OnboardView extends GetView<OnboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (_, context) {
        final width = Get.width;
        final height = Get.height;
        return Stack(
          children: [
            PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.selectedPageIndex,
                itemCount: controller.onboardingPages.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: height,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Image.asset(
                          controller.onboardingPages[index].imageAsset,
                          width: width / 1.5,
                        ),
                        SizedBox(height: 32),
                        Text(
                          controller.onboardingPages[index].title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            controller.onboardingPages[index].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: AppColor.backgroundColor),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            Positioned(
              width: width,
              height: height,
              bottom: height * .28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  controller.onboardingPages.length,
                  (index) => Obx(() {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: AppColor.backgroundColor),
                        color: controller.selectedPageIndex.value == index
                            ? AppColor.backgroundColor
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),
            ),
            Positioned(
              right: width * .25,
              bottom: height * 0,
              child: GestureDetector(
                onTap: controller.forwardAction,
                child: Container(
                  alignment: Alignment.center,
                  width: width / 2,
                  height: height / 15,
                  margin: EdgeInsets.symmetric(vertical: 50),
                  decoration: BoxDecoration(
                      color: AppColor.backgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Obx(() {
                    return Text(
                      controller.isLastPage ? 'Mulai' : 'Berikutnya',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: AppColor.whiteColor),
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
