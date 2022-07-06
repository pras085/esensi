import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/style/app_color.dart';

import '../controllers/detail_perizinan_controller.dart';

class DetailPerizinanView extends GetView<DetailPerizinanController> {
  DetailPerizinanController detailIzinController =
      Get.put(DetailPerizinanController());
  Map<String, dynamic> allData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Uint8List dcdImg = base64.decode(allData['izin']['bukti_foto'].toString());

    print(allData['izin']);
    print(allData['user']);

    String uid = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Perizinan',
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
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('employee')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColor.navigationColor,
                ));
              case ConnectionState.active:
              case ConnectionState.done:
                var listData = {
                  "address": "",
                  "role": "",
                  "employee_id": "",
                  "name": "",
                  "created_at": "",
                  "avatar": "",
                  "position": {"latitude": "", "longitude": ""},
                  "job": "",
                  "email": ""
                };
                String name = "";
                if (snapshot.data != null) {
                  print(snapshot.data.data());
                  listData = snapshot.data.data();
                }
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(20),
                  physics: BouncingScrollPhysics(),
                  children: [
                    // check in ============================================
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                        color: (allData['izin']['status'] == 'true')
                            ? Colors.green
                            : (allData['izin']['status'] == 'false')
                                ? AppColor.error.withOpacity(0.7)
                                : AppColor.primary,
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
                                    'Nama',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    (allData['user']['name'] == null)
                                        ? "-"
                                        : allData['user']['name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              //presence date
                              Text(
                                "${DateFormat.yMMMMEEEEd('id_ID').format(DateTime.parse(allData['izin']["date"]))}",
                                // presenceData["alasan"],
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Text(
                            'Alasan',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            (allData['izin']['alasan'] == null)
                                ? "-"
                                : allData['izin']['alasan'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 14),
                          Text(
                            'Bukti Foto',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 14),
                          dcdImg.isEmpty
                              ? Container(
                                  child: CircularProgressIndicator(
                                  color: AppColor.navigationColor,
                                ))
                              : Image.memory(dcdImg)
                        ],
                      ),
                    ),
                    (listData['role'] == "admin" &&
                            allData['izin']['status'] != 'waiting')
                        ? Container(
                            // height: Get.height * .2,
                            width: Get.width,
                            margin: EdgeInsets.symmetric(vertical: 15),
                            // color: Colors.amber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    detailIzinController.onAcc(
                                      allData['izin']['uid'].toString(),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    width: Get.width * .3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.backgroundColor),
                                    child: Text(
                                      "Terima",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    detailIzinController.onReject(
                                      allData['izin']['uid'].toString(),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    width: Get.width * .3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.error.withOpacity(0.8)),
                                    child: Text(
                                      "Tolak",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox()
                  ],
                );
              default:
                return SizedBox();
            }
          }),
    );
  }
}
