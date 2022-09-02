import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/daftar_karyawan/controllers/daftar_karyawan_controller.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';

class KaryawanTile extends StatelessWidget {
  DaftarKaryawanController controller = Get.find();
  final Map<String, dynamic> karyawanData;
  KaryawanTile({this.karyawanData});

  @override
  Widget build(BuildContext context) {
    // log('${karyawanData['employee_id']}');
    return Dismissible(
      key: Key(karyawanData['uid']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: AppColor.error.withOpacity(0.6),
        child: Icon(
          Icons.delete,
          color: AppColor.whiteColor,
        ),
      ),
      onDismissed: (direction) {
        Get.defaultDialog(
            content: Text('Hapus data ${karyawanData['name']}'),
            confirm: InkWell(
              onTap: () {
                controller.onDeleteUser(karyawanData['uid']);
              },
              child: Container(
                color: AppColor.error,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Hapus',
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              ),
            ),
            cancel: InkWell(
              onTap: () {
                Get.back();
                controller.onRefresh();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Kembali',
                  style: TextStyle(color: AppColor.whiteColor),
                ),
                color: AppColor.primary,
              ),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColor.primaryExtraSoft,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: AppColor.navigationColor,
                      width: 2)),
              child: ClipOval(
                child: Container(
                  width: 40,
                  height: 40,
                  child: Image.network(
                    (karyawanData["avatar"] == null ||
                            karyawanData['avatar'] == "")
                        ? "https://ui-avatars.com/api/?name=${karyawanData['name']}/"
                        : karyawanData['avatar'],
                    fit: BoxFit.cover,
                  ),
                  // child: Image.network(user['avatar'] != null ? ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (karyawanData["name"] == null) ? "-" : karyawanData["name"],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  (karyawanData["email"] == null) ? "-" : karyawanData["email"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (karyawanData["employee_id"] == null)
                      ? "-"
                      : karyawanData["employee_id"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  (karyawanData["job"] == null) ? "-" : karyawanData["job"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
