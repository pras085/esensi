import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';

class PerizinanTile extends StatelessWidget {
  final Map<String, dynamic> perizinanData;
  final Map<String, dynamic> dataUser;

  PerizinanTile({this.perizinanData, this.dataUser});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_PERIZINAN,
          arguments: {"izin": perizinanData, "user": dataUser}),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: (perizinanData["status"] == "waiting")
              ? AppColor.primary.withOpacity(0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: (perizinanData["status"] == "true")
                ? AppColor.success
                : (perizinanData["status"] == "false")
                    ? AppColor.error
                    : AppColor.primary,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
                  textWidthBasis: TextWidthBasis.longestLine,
                ),
              ],
            ),
            Spacer(),
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
