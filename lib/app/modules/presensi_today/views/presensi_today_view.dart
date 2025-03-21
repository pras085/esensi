import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/widgets/presence_today_tile.dart';

import '../../../style/app_color.dart';
import '../controllers/presensi_today_controller.dart';

class PresensiTodayView extends GetView<PresensiTodayController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Presensi Karyawan',
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
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.navigationColor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: GetBuilder<PresensiTodayController>(
        builder: (con) {
          return FutureBuilder<QuerySnapshot>(
            future: controller.getAllUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                      child: CircularProgressIndicator(
                          color: AppColor.navigationColor));
                case ConnectionState.active:
                case ConnectionState.done:
                  var data = snapshot.data;
                  // print("datanya : ${snapshot.data.size}");
                  return ListView.separated(
                    itemCount: data.size,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      var dataUser = data.docs[index].data();
                      log('Hadaras s :$dataUser');
                      // print("data :${dataUser['name']}");
                      // return Container(
                      //   child: Text(dataUser['uid']),
                      // );
                      return Container(
                        child: PresenceTodayTile(dataUser: dataUser),
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
