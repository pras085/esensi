import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';

import '../../../style/app_color.dart';
import '../controllers/info_app_controller.dart';

class InfoAppView extends GetView<InfoAppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.navigationColor,
          title: Text(
            'Tentang Aplikasi',
            style: TextStyle(
                fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset(
              'assets/icons/arrow-left.svg',
              color: AppColor.whiteColor,
            ),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              ClipOval(
                // clipBehavior: Clip.antiAlias,
                child: Container(
                  width: Get.width / 3,
                  height: Get.height / 10,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 4, color: AppColor.backgroundColor),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/icons/logo.png'),
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
              Text(
                'e - sensi',
                style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.navigationColor),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColor.backgroundColor.withOpacity(.8),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: AppColor.whiteColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Versi aplikasi',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColor.whiteColor),
                        ),
                        Spacer(),
                        Text(
                          '1.0.0',
                          style: TextStyle(color: AppColor.whiteColor),
                        )
                      ],
                    ),
                    Divider(
                        thickness: 1,
                        height: 30,
                        color: AppColor.primaryExtraSoft),
                    // SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        LaunchReview.launch(
                          androidAppId: "com.ta.esensi",
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColor.whiteColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Beri rating di Play Store',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColor.whiteColor),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_circle_right)
                        ],
                      ),
                    ),
                    Divider(
                        thickness: 1,
                        height: 30,
                        color: AppColor.primaryExtraSoft),
                    // SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        controller.openWA();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.help_center,
                            color: AppColor.whiteColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Butuh Bantuan ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColor.whiteColor),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_circle_right)
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 30,
                      color: AppColor.primaryExtraSoft,
                    ), // SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        controller.openTerm();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.policy,
                            color: AppColor.whiteColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Kebijakan Privasi',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColor.whiteColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
