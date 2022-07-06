import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

import '../../../style/app_color.dart';
import '../../../widgets/riwayat_perizinan_tile.dart';
import '../controllers/riwayat_perizinan_controller.dart';

class RiwayatPerizinanView extends GetView<RiwayatPerizinanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Riwayat Perizinan',
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
        actions: [
          Container(
            width: 44,
            height: 44,
            margin: EdgeInsets.only(bottom: 8, top: 8, right: 8),
            child: ElevatedButton(
              onPressed: () => Get.toNamed(Routes.TAMBA_PERIZINAN),
              child: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: AppColor.backgroundColor,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ],
        backgroundColor: AppColor.navigationColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: GetBuilder<RiwayatPerizinanController>(
        builder: (con) {
          return FutureBuilder<QuerySnapshot>(
            future: controller.getPerizinan(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                      child: CircularProgressIndicator(
                          color: AppColor.navigationColor));
                case ConnectionState.active:
                case ConnectionState.done:
                  var listPerizinan = snapshot.data.docs;
                  return ListView.separated(
                    itemCount: listPerizinan.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      var perizinanData = listPerizinan[index].data();
                      print(perizinanData["uid"]);
                      return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('employee')
                              .doc(perizinanData['idUser'])
                              .snapshots(),
                          builder: (context, snapshotUser) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.active:
                              case ConnectionState.done:
                                var dataUser = {
                                  "address": "",
                                  "role": "employee",
                                  "employee_id": "",
                                  "name": "",
                                  "created_at": "",
                                  "avatar": "",
                                  "position": {"latitude": "", "longitude": ""},
                                  "job": "",
                                  "email": ""
                                };
                                String name = "";
                                if (snapshotUser.data != null) {
                                  print(snapshotUser.data.data());
                                  dataUser = snapshotUser.data.data();
                                }
                                return RiwayatPerizinanTile(
                                  perizinanData: perizinanData,
                                  dataUser: dataUser,
                                );
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator(
                                        color: AppColor.navigationColor));
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
