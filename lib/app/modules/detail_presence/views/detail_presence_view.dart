import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/style/app_color.dart';

import '../controllers/detail_presence_controller.dart';

class DetailPresenceView extends GetView<DetailPresenceController> {
  // final Map<String, dynamic> presenceData = Get.arguments;
  // final Map<String, dynamic> dataUser = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // log('view ${controller.jamMasuk.hour.toString() + ":" + controller.jamMasuk.minute.toString()}');
    // log('view kluar ${controller.jamKeluar.hour.toString() + ":" + controller.jamKeluar.minute.toString()}');
    // log('con ${controller.jamMasukKantor.hour.toString() + ":" + controller.jamMasukKantor.minute.toString()}');
    // log('con ${controller.jamMasukKantor.hour.toString() + ":" + controller.jamMasukKantor.minute.toString()}');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Presensi',
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 16,
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
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
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: [
          // check in ============================================

          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: (controller.jamMasuk.hour
                      .isGreaterThan(controller.jamMasukKantor.hour))
                  ? Colors.red.shade300
                  : AppColor.primary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.secondaryExtraSoft, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Masuk',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 4),
                        Text(
                          (controller.presenceData["masuk"] == null)
                              ? "-"
                              : "${DateFormat.jm('id_ID').format(DateTime.parse(controller.presenceData["masuk"]["date"]))}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      (controller.presenceData["date"] == null)
                          ? "-"
                          : "${DateFormat.yMMMMEEEEd('id_ID').format(DateTime.parse(controller.presenceData["date"]))}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Text(
                  'Status',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  (controller.jamMasuk != null)
                      ? (controller.jamMasuk.hour
                              .isGreaterThan(controller.jamMasukKantor.hour))
                          ? "Terlambat"
                          : "Masuk"
                      : "-",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 14),
                Text(
                  'Alamat',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  (controller.presenceData["masuk"] == null)
                      ? "-"
                      : "${controller.presenceData["masuk"]["address"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          // check out ===========================================
          controller.presenceData["keluar"] == null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColor.secondaryExtraSoft, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Keluar',
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "-",
                                style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          //presence date
                          Text(
                            "${DateFormat.yMMMMEEEEd('id_ID').format(DateTime.parse(controller.presenceData["date"]))}",
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Text(
                        'Status',
                        style: TextStyle(
                          color: AppColor.whiteColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Tidak Hadir",
                        style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'address',
                        style: TextStyle(
                          color: AppColor.whiteColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "-",
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 150 / 100,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColor.secondaryExtraSoft,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColor.secondaryExtraSoft, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Keluar',
                                style: TextStyle(color: AppColor.secondary),
                              ),
                              SizedBox(height: 4),
                              Text(
                                (controller.presenceData["keluar"] == null)
                                    ? "-"
                                    : "${DateFormat.jm('id_ID').format(DateTime.parse(controller.presenceData["keluar"]["date"]))}",
                                style: TextStyle(
                                    color: AppColor.secondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          //presence date
                          Text(
                            "${DateFormat.yMMMMEEEEd('id_ID').format(DateTime.parse(controller.presenceData["date"]))}",
                            style: TextStyle(color: AppColor.secondary),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Text(
                        'Status',
                        style: TextStyle(color: AppColor.secondary),
                      ),
                      SizedBox(height: 4),
                      Text(
                        controller.jamKeluar == null
                            ? "-"
                            : (controller.jamKeluar.hour.isGreaterThan(
                                    controller.jamKeluarKantor.hour))
                                ? "Lembur " +
                                    "(${controller.jamKeluar.hour - controller.jamKeluarKantor.hour})" +
                                    " jam"
                                : "Masuk",
                        style: TextStyle(
                            color: AppColor.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'address',
                        style: TextStyle(color: AppColor.secondary),
                      ),
                      SizedBox(height: 4),
                      Text(
                        (controller.presenceData["keluar"] == null)
                            ? "-"
                            : "${controller.presenceData["keluar"]["address"]}",
                        style: TextStyle(
                          color: AppColor.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 150 / 100,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
