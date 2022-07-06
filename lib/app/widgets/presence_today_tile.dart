import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';

class PresenceTodayTile extends StatelessWidget {
  final Map<String, dynamic> presenceData;
  final Map<String, dynamic> dataUser;

  PresenceTodayTile({this.presenceData, this.dataUser});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Get.toNamed(Routes.DETAIL_PRESENCE,
      //     arguments: {"presensi": presenceData, "user": dataUser}),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColor.primaryExtraSoft,
          ),
        ),
        padding: EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${dataUser['name']}'),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Masuk",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      (presenceData["masuk"] == null)
                          ? "-"
                          : "${DateFormat.jm('id_ID').format(DateTime.parse(presenceData["masuk"]["date"]))}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Keluar",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      (presenceData["keluar"] == null)
                          ? "-"
                          : "${DateFormat.jm('id_ID').format(DateTime.parse(presenceData["keluar"]["date"]))}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
