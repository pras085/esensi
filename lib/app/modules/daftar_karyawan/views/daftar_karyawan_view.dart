import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

import '../../../style/app_color.dart';
import '../../../widgets/karyawan_tile.dart';
import '../controllers/daftar_karyawan_controller.dart';

class DaftarKaryawanView extends GetView<DaftarKaryawanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Karyawan',
          style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
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
        actions: [
          Container(
            width: 44,
            height: 44,
            margin: EdgeInsets.only(bottom: 8, top: 8, right: 8),
            child: ElevatedButton(
              onPressed: () => Get.toNamed(Routes.ADD_EMPLOYEE),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          HapticFeedback.lightImpact();
          return controller.onRefresh();
        },
        child: ListView(
          shrinkWrap: true,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: controller.streamPegawai(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColor.navigationColor,
                      ));
                    case ConnectionState.active:
                    case ConnectionState.done:
                      List<QueryDocumentSnapshot> listKaryawan =
                          snapshot.data?.docs;

                      // log('${filter}');
                      // var maxId = listKaryawan['employee_id'];

                      return ListView.separated(
                        // itemCount: snapshot.data.docs.length > 0
                        //     ? snapshot.data.docs.length
                        //     : 0,
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          Map<String, dynamic> karyawanData =
                              listKaryawan[index].data();
                          // var maxId = karayaw;
                          return KaryawanTile(
                            karyawanData: karyawanData,
                          );
                        },
                      );
                    default:
                      return SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
