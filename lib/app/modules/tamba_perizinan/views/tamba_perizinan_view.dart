import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../style/app_color.dart';
import '../controllers/tamba_perizinan_controller.dart';

class TambaPerizinanView extends GetView<TambaPerizinanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.navigationColor,
        title: Text(
          'Perizinan',
          style: TextStyle(
              fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100),
        child: Container(
          width: Get.width,
          height: Get.height,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alasan',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold),
              ),
              Material(
                color: Colors.white,
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 14),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1, color: AppColor.secondaryExtraSoft)),
                  child: TextField(
                    onSubmitted: (value) => controller.alasanC,
                    controller: controller.alasanC,
                    style: TextStyle(fontFamily: 'poppins', fontSize: 14),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            'Masukan alasan mengapa anda tidak masuk ...'),
                  ),
                ),
              ),
              Text(
                'Bukti foto',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold),
              ),
              GetBuilder<TambaPerizinanController>(
                  init: controller,
                  builder: (value) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 7),
                      width: Get.width,
                      height: Get.height / 3,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.secondaryExtraSoft.withOpacity(0.7),
                      ),
                      child: controller.imagepath != ""
                          ? Image.file(File(controller.imagepath),
                              fit: BoxFit.fitHeight)
                          : IconButton(
                              onPressed: () async {
                                await controller.openImagePicker();
                                // Get.back();
                              },
                              icon: Icon(Icons.add_a_photo_rounded),
                              iconSize: 35,
                              color: AppColor.navigationColor,
                            ),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => controller.deleteData(),
                    child: Container(
                      width: Get.width / 6,
                      height: Get.height / 15,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.delete, color: AppColor.whiteColor),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        print(controller.alasanC.value);
                        await controller.uploadPerizinan();
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width / 3,
                        height: Get.height / 15,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColor.backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 14,
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
