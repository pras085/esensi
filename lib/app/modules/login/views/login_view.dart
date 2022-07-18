import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: PreferredSize(
              child: SizedBox(
                height: Get.height / 26,
                child: ColoredBox(color: AppColor.backgroundColor),
              ),
              preferredSize: Size.fromHeight(100)),
          body: body(context),
        ));
  }

  Widget body(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      // physics:
      //     AlwaysScrollableScrollPhysics(parent: NeverScrollableScrollPhysics()),
      children: [
        SvgPicture.asset(
          "assets/vector/atas_login.svg",
          alignment: Alignment.topCenter,
          height: Get.height / 3,
          width: Get.width,
        ),
        Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            SvgPicture.asset(
              "assets/vector/33.svg",
              alignment: Alignment.bottomCenter,
              height: Get.height / 1.5,
              width: Get.width,
            ),
            Positioned(
              top: Get.height / 5,
              left: Get.width / 15,
              right: Get.width / 15,
              child: Container(
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColor.whiteColor,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 14, right: 14),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1, color: AppColor.secondaryExtraSoft),
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
                        maxLines: 1,
                        controller: controller.emailC,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text(
                            "Email",
                            style: TextStyle(
                              color: AppColor.secondarySoft,
                              fontSize: 14,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: InputBorder.none,
                          hintText: "youremail@email.com",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            color: AppColor.secondarySoft,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 14, right: 14),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1, color: AppColor.secondaryExtraSoft),
                      ),
                      child: Obx(
                        () => TextField(
                          style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          controller: controller.passC,
                          obscureText: controller.obsecureText.value,
                          decoration: InputDecoration(
                            label: Text(
                              "Password",
                              style: TextStyle(
                                color: AppColor.secondarySoft,
                                fontSize: 14,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: InputBorder.none,
                            hintText: "******",
                            suffixIcon: IconButton(
                              icon: (controller.obsecureText != false)
                                  ? SvgPicture.asset('assets/icons/show.svg')
                                  : SvgPicture.asset('assets/icons/hide.svg'),
                              onPressed: () {
                                controller.obsecureText.value =
                                    !(controller.obsecureText.value);
                              },
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                              color: AppColor.secondarySoft,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (controller.isLoading.isFalse) {
                              await controller.login();
                            }
                          },
                          child: Text(
                            (controller.isLoading.isFalse)
                                ? 'Log in'
                                : 'Loading...',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            elevation: 0,
                            primary: AppColor.navigationColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                        child: Text("Lupa Password ?"),
                        style: TextButton.styleFrom(
                          primary: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
