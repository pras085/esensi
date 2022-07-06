import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SizedBox(
          height: 36,
          child: ColoredBox(color: AppColor.backgroundColor),
        ),
      ),
      // AppBar(
      //   toolbarHeight: 35,
      //   automaticallyImplyLeading: true,
      //   leading: IconButton(
      //     icon: SvgPicture.asset(
      //       'assets/icons/arrow-left.svg',
      //       color: Colors.white,
      //     ),
      //     onPressed: () => Get.back(),
      //   ),
      //   backgroundColor: AppColor.backgroundColor,
      //   elevation: 0,
      // ),
      // extendBodyBehindAppBar: true,
      body: body(context),
    );
  }

  body(context) {
    return Column(
      children: <Widget>[
        // Container(
        //   width: Get.width,
        //   alignment: Alignment.centerLeft,
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 5,
        //   ),
        //   decoration: BoxDecoration(color: AppColor.backgroundColor),
        //   child: IconButton(
        //       icon: Icon(Icons.arrow_back_ios),
        //       iconSize: 23,
        //       color: AppColor.secondaryExtraSoft,
        //       onPressed: () => Get.back()),
        // ),
        Stack(
          // alignment: Alignment.topCenter,
          children: [
            SvgPicture.asset(
              "assets/vector/atas_login.svg",
              alignment: Alignment.topCenter,
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 84),
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Atur Ulang Kata Sandi',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Kami akan mengirimkan link reset password ke email anda.",
                          style: TextStyle(
                              color: AppColor.secondarySoft,
                              height: 150 / 100,
                              fontFamily: 'poppins'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 14, right: 14, top: 4),
                    margin: EdgeInsets.only(bottom: 24),
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
                  Obx(
                    () => Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.isLoading.isFalse) {
                            await controller.sendEmail();
                          }
                        },
                        child: Text(
                          (controller.isLoading.isFalse)
                              ? 'Kirim'
                              : 'Loading...',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          elevation: 0,
                          primary: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SvgPicture.asset(
                "assets/vector/back_abu.svg",
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
