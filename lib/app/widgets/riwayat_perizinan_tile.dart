import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';

class RiwayatPerizinanTile extends StatelessWidget {
  final Map<String, dynamic> perizinanData;
  final Map<String, dynamic> dataUser;
  RiwayatPerizinanTile({this.perizinanData, this.dataUser});
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
                  "Hari/Tanggal",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  "${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(perizinanData["date"]))}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              (perizinanData["status"] == "true")
                  ? Icons.verified
                  : (perizinanData["status"] == "false")
                      ? Icons.do_disturb_outlined
                      : Icons.update_outlined,
              color: (perizinanData["status"] == "true")
                  ? AppColor.success
                  : (perizinanData["status"] == "false")
                      ? AppColor.error.withOpacity(0.8)
                      : AppColor.navigationColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
