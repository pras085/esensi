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
          'Presensi Hari Ini',
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
                      var presenceDataToday = data.docs[index].data();
                      // print("data :${presenceDataToday['name']}");
                      // return Container(
                      //   child: Text(presenceDataToday['uid']),
                      // );
                      return StreamBuilder<DocumentSnapshot>(
                          stream: controller
                              .streamTodayPresence(presenceDataToday['uid']),
                          builder: (context, snapshotUser) {
                            switch (snapshotUser.connectionState) {
                              case ConnectionState.active:
                              case ConnectionState.done:
                                var dataUser = {
                                  "uid": "",
                                  "role": "",
                                  "employee_id": "",
                                  "name": "",
                                  "created_at": "",
                                  "avatar": "",
                                  "adress": "",
                                  "position": {"latitude": "", "longitude": ""},
                                  "job": "",
                                  "email": ""
                                };
                                var dataPresence = {
                                  "date": "",
                                  "masuk": {
                                    "address": "",
                                    "date": "",
                                    "distance": "",
                                    "in_area": "",
                                    "latitude": "",
                                    "longitude": "",
                                  },
                                  "keluar": {
                                    "address": "",
                                    "date": "",
                                    "distance": "",
                                    "in_area": "",
                                    "latitude": "",
                                    "longitude": "",
                                  },
                                };
                                String name = "";
                                if (snapshotUser.data != null) {
                                  // print(
                                  //     "INI DATA USER : ${presenceDataToday['name']}");
                                  dataUser = presenceDataToday;
                                }

                                if (snapshotUser.data.exists) {
                                  // print(
                                  //     "INI DATA PRESENSI : ${snapshotUser.data['date']}");
                                  dataPresence = snapshotUser.data.data();
                                }
                                return snapshotUser.data.exists
                                    ? PresenceTodayTile(
                                        presenceData: dataPresence,
                                        dataUser: dataUser,
                                      )
                                    : Container();

                              case ConnectionState.waiting:
                                return SizedBox();
                              default:
                                return Center(child: Text("Error"));
                            }
                          });
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
