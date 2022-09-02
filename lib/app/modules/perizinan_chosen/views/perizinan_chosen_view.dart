import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:presence/app/widgets/perizinan_chosen_tile.dart';

import '../../../style/app_color.dart';
import '../controllers/perizinan_chosen_controller.dart';

class PerizinanChosenView extends GetView<PerizinanChosenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Riwayat Presensi',
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: AppColor.whiteColor,
          ),
        ),
        backgroundColor: AppColor.navigationColor,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: GetBuilder<PerizinanChosenController>(
        builder: (con) {
          log(Get.arguments);
          return FutureBuilder<DocumentSnapshot>(
            future: controller.getAllPerizinan(Get.arguments),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColor.navigationColor,
                  ));
                case ConnectionState.active:
                case ConnectionState.done:
                  var data = snapshot.data.data();
                  return ListView.separated(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      var perizinanData = data[index][data];
                      log(perizinanData);
                      return PerizinanChosenTile(
                        perizinanData: perizinanData,
                      );
                    },
                  );
                default:
                  return SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
