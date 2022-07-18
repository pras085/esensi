import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
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
      // extendBodyBehindAppBar: true,
      body: body(context),
    );
  }

  body(context) {
    return Column(
      children: <Widget>[
        Stack(
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
                          'Kata Sandi Baru',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Kamu masuk menggunakan password default, kamu harus membuat password baru.",
                          style: TextStyle(
                            color: AppColor.secondarySoft,
                            height: 150 / 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => CustomInput(
                      controller: controller.passC,
                      label: 'Password Baru',
                      hint: '********',
                      obsecureText: controller.newPassObs.value,
                      suffixIcon: IconButton(
                        icon: (controller.newPassObs.value != false)
                            ? SvgPicture.asset('assets/icons/show.svg')
                            : SvgPicture.asset('assets/icons/hide.svg'),
                        onPressed: () {
                          controller.newPassObs.value =
                              !(controller.newPassObs.value);
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomInput(
                      controller: controller.confirmPassC,
                      label: 'Konfirmasi Password Baru',
                      hint: '********',
                      obsecureText: controller.newPassCObs.value,
                      suffixIcon: IconButton(
                        icon: (controller.newPassCObs.value != false)
                            ? SvgPicture.asset('assets/icons/show.svg')
                            : SvgPicture.asset('assets/icons/hide.svg'),
                        onPressed: () {
                          controller.newPassCObs.value =
                              !(controller.newPassCObs.value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Obx(
                    () => Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.isLoading.isFalse) {
                            print('exc');
                            controller.newPassword();
                          }
                        },
                        child: Text(
                          (controller.isLoading.isFalse)
                              ? 'Lanjutkan'
                              : 'Memuat...',
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
            ],
          ),
        ),
      ],
    );
  }
}
