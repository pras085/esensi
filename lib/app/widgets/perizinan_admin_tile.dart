import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';

class PerizinanAdminTile extends StatelessWidget {
  final Map<String, dynamic> perizinanData;
  final Map<String, dynamic> dataUser;
  PerizinanAdminTile({this.perizinanData, this.dataUser});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.DETAIL_PERIZINAN,
          arguments: {"izin": perizinanData, "user": dataUser}),
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      (dataUser["name"] == null) ? "-" : dataUser["name"],
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
                      "Status",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      (perizinanData["status"] == true)
                          ? "-"
                          : perizinanData["status"],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(perizinanData["date"]))}",

              // "${DateFormat.yMMMMEEEEd().format(DateTime.parse(presenceData["date"]))}",
              style: TextStyle(
                fontSize: 10,
                color: AppColor.secondarySoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
